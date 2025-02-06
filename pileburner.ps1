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

# Find the correct CRD installation path
$crdPath = Get-ChildItem -Path "C:\Program Files (x86)\Google\Chrome Remote Desktop" -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$exePath = "$($crdPath.FullName)\remoting_start_host.exe"

if (Test-Path $exePath) {
    Write-Host "Found Chrome Remote Desktop at: $exePath"
    
    # Configure Remote Desktop Access
    Start-Process -FilePath $exePath `
      -ArgumentList "--code=""4/0ASVgi3I55s0N7x2nF4GZvJm2_in5mxTBnecAFlzGWYfB-m-jlbVNLuhXXjBVO9XB0DHosQ"" --redirect-url=""https://remotedesktop.google.com/_/oauthredirect"" --name=$Env:COMPUTERNAME --pin=654321" `
      -Wait

    Write-Host "Remote Desktop Setup Complete! Use PIN 654321 to connect."
} else {
    Write-Host "Error: remoting_start_host.exe not found!"
}

# Run the PowerShell Code from GitHub Actions Input
if (![string]::IsNullOrEmpty($Env:INPUT_CODE)) {
    Write-Host "Executing User Code from Workflow..."
    Invoke-Expression "$Env:INPUT_CODE"
} else {
    Write-Host "No user code provided. Skipping execution."
}

Write-Host "Setup Complete! System is now accessible remotely."
