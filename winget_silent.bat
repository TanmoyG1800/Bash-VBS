@echo off
setlocal

:: Variables
set URL=https://github.com/microsoft/winget-cli/releases/download/v1.8.1911/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
set OUTPUT=C:\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

:: Download the App Installer package silently
powershell.exe -WindowStyle Hidden -NoProfile -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%OUTPUT%'"

:: Check if the download was successful
if %ERRORLEVEL% neq 0 (
    echo Failed to download Winget.
    exit /b 1
)

:: Install the package silently
powershell.exe -WindowStyle Hidden -NoProfile -Command "Add-AppxPackage -Path '%OUTPUT%'"

:: Check if the installation was successful
if %ERRORLEVEL% neq 0 (
    echo Failed to install Winget.
    exit /b 1
)

:: Verify the installation silently
powershell.exe -WindowStyle Hidden -NoProfile -Command "winget --version" >nul 2>&1

if %ERRORLEVEL% neq 0 (
    echo Winget installation failed or Winget is not installed correctly.
    exit /b 1
)

echo Winget installed successfully.
exit /b 0
