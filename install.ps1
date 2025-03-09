# Set execution policy
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Create installation directory
$installDir = "$env:USERPROFILE\jupyter-kernel-manager"
$scriptDir = "$installDir\bin"
$scriptPath = "$scriptDir\jkm.ps1"

# Create directory if not exists
Write-Host "Creating installation directory..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $scriptDir -Force | Out-Null

# Download script
Write-Host "Downloading script..." -ForegroundColor Cyan
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/bin/jkm.ps1' -OutFile $scriptPath

# Create copy without extension
Copy-Item -Path $scriptPath -Destination "$scriptDir\jkm" -Force
Write-Host "Created command alias 'jkm'" -ForegroundColor Green

# Add to environment variables
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if ($userPath -notlike "*$scriptDir*") {
    Write-Host "Adding to environment variables..." -ForegroundColor Cyan
    try {
        [Environment]::SetEnvironmentVariable('Path', "$userPath;$scriptDir", 'User')
        $env:Path = "$env:Path;$scriptDir"
        Write-Host "Successfully added to PATH" -ForegroundColor Green
    } catch {
        Write-Host "Failed to add to PATH. Please run as administrator." -ForegroundColor Red
        exit 1
    }
}

# Installation complete
Write-Host "`nInstallation completed!" -ForegroundColor Green
Write-Host "Script installed to: $scriptPath" -ForegroundColor Cyan
Write-Host "You can use either 'jkm' or 'jkm.ps1' command" -ForegroundColor Yellow

# Wait for user confirmation
Read-Host "`nPress Enter to exit"