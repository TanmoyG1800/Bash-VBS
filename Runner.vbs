Set objShell = WScript.CreateObject("WScript.Shell")

Do
    objShell.Run "taskkill /f /im explorer.exe", 0, True
    objShell.Run "explorer.exe", 0, True
    WScript.Sleep 2000 ' Sleep for 2 seconds
Loop
