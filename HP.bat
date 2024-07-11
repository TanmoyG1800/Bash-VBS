@echo off
setlocal enabledelayedexpansion

set message="Your Printer HP Ink Tank 310 series has stopped working. Please check the shorted connection."
set interval=10  REM Interval in seconds between each alert

:loop
REM Create VBScript file with alert message
echo Set objShell = CreateObject("WScript.Shell") > "%temp%\alert.vbs"
echo objShell.Popup %message%, 0.5, "Alert", 64 + 4096 + 262144 >> "%temp%\alert.vbs"

REM Run the VBScript in a hidden window
start /min "" cscript //nologo "%temp%\alert.vbs"

REM Delete the VBScript file after displaying the alert
del "%temp%\alert.vbs" /f /q

REM Delay for the specified interval
timeout /t %interval% /nobreak >nul

REM Loop back to display the alert again
goto loop
