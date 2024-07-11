param (
    [string]$url = "https://github.com/microsoft/winget-cli/releases/download/v1.8.1911/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle",
    [string]$output = "C:\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle",
    [string]$logfile = "C:\winget_install_log.txt"
)

# Clear previous log file
if (Test-Path $logfile) {
    Remove-Item $logfile
}

# Download the App Installer package
try {
    Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop
} catch {
    Add-Content $logfile "Failed to download Winget: $_"
    exit 1
}

# Verify the downloaded file exists and is not empty
if (-Not (Test-Path $output) -Or (Get-Item $output).Length -lt 10000) {
    Add-Content $logfile "Downloaded file not found or appears to be incomplete."
    exit 1
}

# Install the package
try {
    Add-AppxPackage -Path $output -ErrorAction Stop
} catch {
    Add-Content $logfile "Failed to install Winget: $_"
    exit 1
}

# Verify the installation
try {
    winget --version | Out-Null
} catch {
    Add-Content $logfile "Winget installation failed or Winget is not installed correctly: $_"
    exit 1
}

Add-Content $logfile "Winget installed successfully."
exit 0
