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
[int]$a=1;

while($a -le 10){
    Write-Host -ForegroundColor Green "Current number is: $a"
    $a+=1;
    Start-Sleep 1
}
# Using a hashtable and an array
Write-Host "Using a hashtable and an array:" -ForegroundColor Yellow
[hashtable]$hashTable = @{
    Name = "Alice"
    Age = 25
    City = "New York"
};
$hashTable.GetEnumerator() | ForEach-Object {
    Write-Host "$($_.Key): $($_.Value)" -ForegroundColor Magenta
}

$array = @(1,2,34,5,6,7,8,9,10)
$array | ForEach-Object {
    if($_ % 2 -eq 0){
        Write-Host "Even number: $_" -ForegroundColor Blue
    } else {
        Write-Host "Odd number: $_" -ForegroundColor Red
    }
};

# Using a switch statement
Write-Host "Using a switch statement:" -ForegroundColor Yellow
switch ($a) {
    1 { Write-Host "One" -ForegroundColor Green }
    2 { Write-Host "Two" -ForegroundColor Green }
    3 { Write-Host "Three" -ForegroundColor Green }
    default { Write-Host "Not one, two, or three" -ForegroundColor Red }
}       
# Using a try-catch block
Write-Host "Using a try-catch block:" -ForegroundColor Yellow
try {
    $result = 10 / 0
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
} finally {
    Write-Host "This block always executes." -ForegroundColor Cyan
}
# Using a function
Write-Host "Using a function:" -ForegroundColor Yellow
function Get-Square {
    param (
        [int]$number
    )
    return $number * $number
}
$result = Get-Square -number 5
Write-Host "The square of 5 is: $result" -ForegroundColor Magenta
# Base64 encoding example
Write-Host "Base64 encoding example:" -ForegroundColor Yellow
$originalString = "Hello, PowerShell!"
$bytes = [System.Text.Encoding]::UTF8.GetBytes($originalString)
$base64String = [System.Convert]::ToBase64String($bytes)
Write-Host "Base64 Encoded String: $base64String" -ForegroundColor Cyan