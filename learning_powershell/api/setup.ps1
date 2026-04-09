# Run this once to download SQLite DLL
$dir = "$PSScriptRoot\lib"
New-Item -ItemType Directory -Force -Path $dir | Out-Null

$url  = "https://github.com/praeclarum/sqlite-net/raw/master/src/SQLite.cs"
$nuget = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"

# Download via NuGet
Invoke-WebRequest $nuget -OutFile "$dir\nuget.exe"
& "$dir\nuget.exe" install System.Data.SQLite.Core -OutputDirectory "$dir" -NonInteractive

# Find and copy the DLL
$dll = Get-ChildItem "$dir" -Recurse -Filter "System.Data.SQLite.dll" | Select-Object -First 1
Copy-Item $dll.FullName "$dir\System.Data.SQLite.dll" -Force

Write-Host "SQLite DLL ready at $dir\System.Data.SQLite.dll"
