@echo off
:loop
tasklist | find /i "explorer.exe" > nul
if %errorlevel% equ 0 (
    echo Killing explorer.exe...
    taskkill /f /im explorer.exe
) else (
    echo explorer.exe not found.
)

timeout /t 5 /nobreak > nul
goto loop
