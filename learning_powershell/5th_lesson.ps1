<#
hello world
multiline comment
#>

# Get Autorun
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

Get-NetTCPConnection | Where-Object { $_.State -eq "Established" }

# Get Scheduled Tasks
Get-ScheduledTask | Where-Object {$_.TaskPath -notlike "\Microsoft*"}

# Get Auto run
Get-ChildItem "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

wmic os get * 
wmic cpu get *
