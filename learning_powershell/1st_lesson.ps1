Write-Host "Welcome to PowerShell!" -ForegroundColor White -BackgroundColor Blue
Write-Host "hello world this is me" -OutBuffer 1
$a = $(Get-Process | Select-Object -Last 5)

foreach($process in $a){
    Write-Host "Process Name: $($process.Name) - ID: $($process.Id)" -ForegroundColor Green
}
for($b = 0; $b -lt 5; $b++){
    Write-Host "This is iteration number: $b" -ForegroundColor Yellow
}
$b = 0;
do{
    Write-Host "This is a do-while loop iteration number: $b" -ForegroundColor Cyan
    $b++
}while($b -lt 5)