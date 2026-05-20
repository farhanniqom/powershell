# 1. Pastikan skrip berjalan sebagai Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Skrip ini harus dijalankan sebagai Administrator!"
    Exit
}

# 2. Ambil input password DSRM secara aman dari user
$DSRMPassword = Read-Host -Prompt "Masukkan Password DSRM untuk Domain Controller" -AsSecureString

# 3. Install Fitur AD DS binaries jika belum ada
Write-Host "Mengunduh dan memasang fitur AD DS..." -ForegroundColor Cyan
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# 4. Definisikan parameter menggunakan Splatting
$ADDSParams = @{
    DomainName                    = "farhan.local"
    DomainNetbiosName             = "CORP"
    ForestMode                    = "WinThreshold" # Standar tertinggi untuk Server 2016/2019/2022
    DomainMode                    = "WinThreshold"
    InstallDns                    = $true
    SafeModeAdministratorPassword = $DSRMPassword
    CreateDnsDelegation           = $false
    DatabasePath                  = "C:\Windows\NTDS"
    LogPath                       = "C:\Windows\NTDS"
    SysVolPath                    = "C:\Windows\SYSVOL"
    Force                         = $true
}

# 5. Lakukan uji kelayakan (Prerequisite Check)
Write-Host "Menjalankan verifikasi prasyarat..." -ForegroundColor Cyan
Import-Module ADDSDeployment
$TestResult = Test-ADDSForestInstallation @ADDSParams

# 6. Jika verifikasi lolos, eksekusi instalasi forest baru
if ($TestResult.Status -eq "Success" -or $TestResult.Status -eq "Warning") {
    Write-Host "Prasyarat terpenuhi. Memulai promosi Domain Controller..." -ForegroundColor Green
    Install-ADDSForest @ADDSParams
} else {
    Write-Error "Verifikasi gagal. Silakan periksa konfigurasi jaringan atau nama domain Anda."
}