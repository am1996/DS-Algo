$regOutput = reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"

$regOutput | foreach {
    if ($_ -match ".*REG_SZ\s+(.*)") {
        $matches[1]   # prints only the data (path)
    }
}
