# Jalankan PowerShell sebagai Administrator

Write-Host "Memblokir USB Storage..."

# Disable USB Storage service
Set-ItemProperty `
-Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" `
-Name "Start" `
-Value 4

Write-Host "USB Storage berhasil diblokir."
Write-Host "Restart komputer diperlukan."