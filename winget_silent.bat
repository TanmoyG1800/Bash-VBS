@echo off
setlocal

:: Variables
set URL=https://github.com/microsoft/winget-cli/releases/download/v1.8.1911/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
set OUTPUT=C:\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
set LOGFILE=C:\winget_install_log.txt

:: Clear previous log file
if exist %LOGFILE% del %LOGFILE%

:: Download the App Installer package silently
powershell.exe -WindowStyle Hidden -NoProfile -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%OUTPUT%'" >> %LOGFILE% 2>&1

:: Check if the download was successful
if %ERRORLEVEL% neq 0 (
    echo Failed to download Winget. See log file for details: %LOGFILE%
    exit /b 1
)

:: Verify the downloaded file exists and is not empty
if not exist "%OUTPUT%" (
    echo Downloaded file not found. See log file for details: %LOGFILE%
    exit /b 1
)
for %%I in ("%OUTPUT%") do if %%~zI lss 10000 (
    echo Downloaded file appears to be incomplete. See log file for details: %LOGFILE%
    exit /b 1
)

:: Install the package silently
powershell.exe -WindowStyle Hidden -NoProfile -Command "Add-AppxPackage -Path '%OUTPUT%'" >> %LOGFILE% 2>&1

:: Check if the installation was successful
if %ERRORLEVEL% neq 0 (
    echo Failed to install Winget. See log file for details: %LOGFILE%
    exit /b 1
)

:: Verify the installation silently
powershell.exe -WindowStyle Hidden -NoProfile -Command "winget --version" >> %LOGFILE% 2>&1

if %ERRORLEVEL% neq 0 (
    echo Winget installation failed or Winget is not installed correctly. See log file for details: %LOGFILE%
    exit /b 1
)

echo Winget installed successfully. See log file for details: %LOGFILE%
exit /b 0
