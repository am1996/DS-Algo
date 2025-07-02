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
    $b++;
}while($b -lt 5);

class a : System.Object {
    [string]$name = "Default Name"
    [int]$age = 0

    a([string]$name, [int]$age) {
        $this.name = $name
        $this.age = $age
    }
}
$instance = [a]::new("John Doe", 30)
Write-Host "Name: $($instance.name), Age: $($instance.age)" -ForegroundColor Magenta
[Math]::Sqrt(16) | Write-Host -ForegroundColor Cyan
[System.DateTime]::Now | Where-Object {
    $_.Hour -ge 12
} | ForEach-Object {
    Write-Host "Current time is: $($_.ToString('HH:mm:ss'))" -ForegroundColor Green
}