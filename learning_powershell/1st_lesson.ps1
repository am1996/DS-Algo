Write-Host "Welcome to PowerShell!" -ForegroundColor White -BackgroundColor Blue
Write-Host "hello world this is me" -OutBuffer 1
$a = $(Get-Process | Select-Object -Last 5)

foreach($process in $a){
    Write-Host "Process Name: $($process.Name) - ID: $($process.Id)" -ForegroundColor Green
}