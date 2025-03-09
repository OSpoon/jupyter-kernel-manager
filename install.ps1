# Set execution policy
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Define installation path
$scriptPath = "$env:USERPROFILE\jkm.ps1"

# Download script
Write-Host "Downloading script..." -ForegroundColor Cyan
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/jkm.ps1' -OutFile $scriptPath

# Add to environment variables
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if ($userPath -notlike "*$env:USERPROFILE*") {
    Write-Host "Adding to environment variables..." -ForegroundColor Cyan
    [Environment]::SetEnvironmentVariable('Path', "$userPath;$env:USERPROFILE", 'User')
}

# Installation complete
Write-Host "`nInstallation completed!" -ForegroundColor Green
Write-Host "Please restart your terminal and use 'jkm.ps1' command" -ForegroundColor Yellow

# Wait for user confirmation
Read-Host "`nPress Enter to exit"