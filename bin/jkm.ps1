# Show menu and get user choice
Write-Host "`nJupyter Kernel Manager" -ForegroundColor Cyan
Write-Host "1. Add new kernel" -ForegroundColor Green
Write-Host "2. Remove existing kernel" -ForegroundColor Yellow
Write-Host "3. Exit" -ForegroundColor Red
$choice = Read-Host "`nPlease enter your choice (1-3)"

switch ($choice) {
    "1" {
        # Original add kernel code
        $envName = Read-Host "Please enter the environment name"
        if ([string]::IsNullOrWhiteSpace($envName)) {
            Write-Host "Environment name cannot be empty!" -ForegroundColor Red
            exit 1
        }

        $useCustomDisplay = Read-Host "Do you want to set a custom display name? (y/N)"
if ($useCustomDisplay.ToLower() -eq 'y') {
    $displayName = Read-Host "Please enter the display name"
    if ([string]::IsNullOrWhiteSpace($displayName)) {
        $displayName = $envName
    }
} else {
    $displayName = $envName
}

# Check if conda is installed
if (-not (Get-Command conda -ErrorAction SilentlyContinue)) {
    Write-Host "Error: conda command not found. Please ensure Anaconda or Miniconda is installed" -ForegroundColor Red
    exit 1
}

# Get list of all conda environments and create if not exists
$envList = (conda env list) -join "`n"
Write-Host "Checking if environment '$envName' exists..."

# Use exact matching for environment name
$envExists = $envList -split "`n" | Where-Object { $_ -match "^(?:\s+)?$envName\s+" }

if (-not $envExists) {
    Write-Host "Environment '$envName' not found, creating..." -ForegroundColor Yellow
    conda create -n $envName python ipykernel -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to create environment!" -ForegroundColor Red
        exit 1
    }
}

# Install kernel directly
Write-Host "Adding environment to Jupyter..." -ForegroundColor Green
# Execute command directly in the target environment using conda run
conda run -n $envName python -m ipykernel install --user --name $envName --display-name $displayName

if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully added environment '$envName' to Jupyter!" -ForegroundColor Green
    Write-Host "Display name: '$displayName'" -ForegroundColor Green
    Write-Host "`nTo see the new kernel, please restart Jupyter Lab:" -ForegroundColor Cyan
    Write-Host "1. Close all Jupyter Lab windows" -ForegroundColor Cyan
    Write-Host "2. Open terminal and run: jupyter lab" -ForegroundColor Cyan
} else {
    Write-Host "Failed to add environment to Jupyter!" -ForegroundColor Red
}
    }
    "2" {
        # List available kernels
        Write-Host "`nAvailable kernels:" -ForegroundColor Cyan
        $kernels = jupyter kernelspec list
        
        # Filter and display non-default kernels
        Write-Host "`nRemovable kernels:" -ForegroundColor Green
        $userKernels = $kernels | Where-Object { 
            $_ -notmatch "deno|python3$"
        }
        
        if (-not $userKernels) {
            Write-Host "No removable kernels found." -ForegroundColor Yellow
            return
        }
        
        $userKernels | ForEach-Object { Write-Host $_ }

        # Get kernel name to remove
        $kernelToRemove = Read-Host "`nPlease enter the kernel name to remove (or press Enter to cancel)"
        if ([string]::IsNullOrWhiteSpace($kernelToRemove)) {
            Write-Host "Operation cancelled." -ForegroundColor Yellow
            return
        }

        # Verify if it's not a protected kernel
        if ($kernelToRemove -match "^(deno|python3)$") {
            Write-Host "Cannot remove protected kernel '$kernelToRemove'!" -ForegroundColor Red
            return
        }

        # Remove the kernel
        Write-Host "Removing kernel '$kernelToRemove'..." -ForegroundColor Yellow
        jupyter kernelspec remove $kernelToRemove -f
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully removed kernel '$kernelToRemove'!" -ForegroundColor Green
            Write-Host "`nTo see the changes, please restart Jupyter Lab:" -ForegroundColor Cyan
            Write-Host "1. Close all Jupyter Lab windows" -ForegroundColor Cyan
            Write-Host "2. Open terminal and run: jupyter lab" -ForegroundColor Cyan
        } else {
            Write-Host "Failed to remove kernel!" -ForegroundColor Red
        }
    }
    "3" {
        Write-Host "Exiting..." -ForegroundColor Yellow
        exit 0
    }
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
        exit 1
    }
}