<#
hello world
multiline comment
#>
# Get Autorun
Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

Get-NetTCPConnection | Where-Object { $_.State -eq "Established" }
