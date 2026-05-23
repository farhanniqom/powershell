# 1. Matikan Wi-Fi agar tidak berebut jalur internet dengan LAN
nmcli radio wifi off

# 2. Cek nama interface kartu LAN fisik Anda
nmcli device
# (Catatan: Cari yang TYPE-nya 'ethernet', misal: enp3s0)

# 3. Hapus sisa-sisa konfigurasi br0 yang lama (jika ada)
sudo nmcli connection delete br0-slave 2>/dev/null
sudo nmcli connection delete br0 2>/dev/null
sudo virsh net-destroy br0-bridge 2>/dev/null
sudo virsh net-undefine br0-bridge 2>/dev/null

# 1. Buat interface bridge utama bernama kvmbr0
sudo nmcli connection add type bridge con-name kvmbr0 ifname kvmbr0

# 2. Masukkan kartu LAN fisik Anda sebagai anggota jembatan
sudo nmcli connection add type bridge-slave con-name kvmbr0-slave ifname enp3s0 master kvmbr0

# 3. Aktifkan jembatan jaringan yang baru
sudo nmcli connection up kvmbr0