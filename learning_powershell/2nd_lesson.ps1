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
if( Get-Item -Path ".\loppy" -ErrorAction SilentlyContinue ) {
    Write-Host "Directory 'loppy' already exists." -ForegroundColor Yellow
} else {
    Write-Host "Directory 'loppy' does not exist. Creating it now..." -ForegroundColor Yellow
    New-Item -Path ".\loppy" -ItemType Directory | ForEach-Object {
        Write-Host "Created directory: $($_.FullName)" -ForegroundColor Green
    }
}
