Defender\Get-MpComputerStatus | ForEach-Object {
    Write-Host "Antivirus Status: $($_.AMServiceEnabled)" -ForegroundColor Green
    Write-Host "Real-time Protection Enabled: $($_.RealTimeProtectionEnabled)" -ForegroundColor Green
}

Get-Acl | ForEach-Object {
    Write-Host "Access Control List for: $($_.Path)" -ForegroundColor Cyan
    $_.Access | ForEach-Object {
        Write-Host "Identity: $($_.IdentityReference) - Access Control Type: $($_.AccessControlType) - Rights: $($_.FileSystemRights)" -ForegroundColor Magenta
    }
}
if ( Get-Item -Path ".\lobby" -ErrorAction SilentlyContinue ) {
    Write-Host "Directory 'lobby' already exists." -ForegroundColor Yellow
}
else {
    Write-Host "Directory 'lobby' does not exist. Creating it now..." -ForegroundColor Yellow
    New-Item -Path ".\lobby" -ItemType Directory | ForEach-Object {
        Write-Host "Created directory: $($_.FullName)" -ForegroundColor Green
    }
}
New-Item -Path ".\lobby\file.txt" -ItemType File | ForEach-Object {
    Write-Host "Created file: $($_.FullName)" -ForegroundColor Green
    Write-Host "Writing to file..." -ForegroundColor Green
    Add-Content -Path $_.FullName -Value "This is a sample text file." | ForEach-Object {
        Write-Host "Content added to file: $($_.FullName)" -ForegroundColor Green
    }
}
