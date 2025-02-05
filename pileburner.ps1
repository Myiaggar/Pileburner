# PowerShell Script: ripper_final.ps1
# Author: TD's Tremendous Rips

Write-Host "Downloading and Installing Google Remote Desktop..."

# Download GRD Installer (Official Link)
Invoke-WebRequest -Uri "https://dl.google.com/dl/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi" -OutFile "$env:TEMP\chromeremotedesktophost.msi"

# Install Google Remote Desktop
Start-Process "$env:TEMP\chromeremotedesktophost.msi" -ArgumentList "/silent /install" -Wait

Write-Host "GRD Installed Successfully!"

# Configure GRD for Remote Access with PIN 654321
Write-Host "Setting Up Remote Desktop..."
Start-Process -FilePath "C:\Program Files (x86)\Google\Chrome Remote Desktop\remoting_start_host.exe" -ArgumentList "--pin=654321" -Wait

Write-Host "Remote Desktop Setup Complete!"

# Run the PowerShell Code from GitHub Actions Input
Write-Host "Executing User Code from Workflow..."
Invoke-Expression "${{ inputs.code }}"

Write-Host "Setup Complete! Connect using Google Remote Desktop with PIN: 654321"