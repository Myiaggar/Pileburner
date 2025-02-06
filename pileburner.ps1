# PowerShell Script: pileburner.ps1
# Author: TD's Tremendous Rips

Write-Host "Starting Pileburner Setup..."

# Download and Install Google Remote Desktop Host
Write-Host "Downloading Google Remote Desktop Host..."
$crdInstaller = "$env:TEMP\chromeremotedesktophost.msi"
Invoke-WebRequest -Uri "https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi" -OutFile $crdInstaller

Write-Host "Installing Google Remote Desktop Host..."
Start-Process msiexec.exe -ArgumentList "/i $crdInstaller /quiet /norestart" -Wait

Write-Host "CRD Installed Successfully!"

# Wait for installation to complete
Start-Sleep -Seconds 10

# Configure Remote Desktop Access
Write-Host "Configuring Remote Desktop..."
Start-Process -FilePath "C:\Program Files (x86)\Google\Chrome Remote Desktop\CurrentVersion\remoting_start_host.exe" `
  -ArgumentList "--code=""4/0ASVgi3I55s0N7x2nF4GZvJm2_in5mxTBnecAFlzGWYfB-m-jlbVNLuhXXjBVO9XB0DHosQ"" --redirect-url=""https://remotedesktop.google.com/_/oauthredirect"" --name=$Env:COMPUTERNAME --pin=654321" `
  -Wait

Write-Host "Remote Desktop Setup Complete! Use PIN 654321 to connect."

# Run the PowerShell Code from GitHub Actions Input
Write-Host "Executing User Code from Workflow..."
Invoke-Expression "$Env:INPUT_CODE"

Write-Host "Setup Complete! System is now accessible remotely."