# Jalankan sebagai Administrator

Write-Host "Mengaktifkan kembali USB Storage..."

Set-ItemProperty `
-Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR" `
-Name "Start" `
-Value 3

Write-Host "USB Storage berhasil diaktifkan kembali."
Write-Host "Restart komputer diperlukan."