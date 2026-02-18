# 🚀 Installation

Panduan lengkap instalasi Termux App Store di perangkat Android kamu.

---

## Prasyarat

Sebelum install, pastikan kamu sudah punya:

| Prasyarat | Versi Minimum | Cara Cek |
|---|---|---|
| Termux | Terbaru (F-Droid) | `termux-info` |
| Python | 3.8+ | `python --version` |
| curl | Any | `curl --version` |
| git | Any | `git --version` |

> ⚠️ **Gunakan Termux dari F-Droid**, bukan dari Google Play Store. Versi Play Store sudah tidak diupdate.

---

## Metode 1 — Installer Otomatis (Disarankan)

Cara tercepat dan paling mudah:

```bash
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash
```

Script akan otomatis:
1. Mengecek dependensi
2. Download Termux App Store
3. Setup PATH
4. Verifikasi instalasi

Setelah selesai, langsung jalankan:

```bash
termux-app-store
```

---

## Metode 2 — Manual via Git

Cocok jika kamu ingin kontrol penuh atau ingin berkontribusi:

```bash
# 1. Clone repo
git clone https://github.com/djunekz/termux-app-store.git
cd termux-app-store

# 2. Install dependensi Python
pip install -r requirements.txt

# 3. Jalankan langsung
python termux-app-store.py

# 4. (Opsional) Setup alias supaya bisa dipanggil dari mana saja
echo 'alias termux-app-store="python ~/termux-app-store/termux-app-store.py"' >> ~/.bashrc
source ~/.bashrc
```

---

## Metode 3 — Binary Release

Download binary yang sudah dikompilasi, tidak butuh Python:

```bash
# 1. Lihat release terbaru di:
# https://github.com/djunekz/termux-app-store/releases

# 2. Download binary sesuai arsitektur kamu
ARCH=$(uname -m)
echo "Arsitektur kamu: $ARCH"

# 3. Download (sesuaikan versi)
curl -L "https://github.com/djunekz/termux-app-store/releases/latest/download/termux-app-store-${ARCH}" \
  -o termux-app-store

# 4. Beri izin eksekusi
chmod +x termux-app-store

# 5. Pindah ke PATH
mv termux-app-store $PREFIX/bin/

# 6. Jalankan
termux-app-store
```

> 💡 Tidak tahu arsitektur kamu? Jalankan `uname -m` untuk cek.

---

## Verifikasi Instalasi

Setelah install, verifikasi dengan:

```bash
# Cek versi
termux-app-store version

# Cek bantuan
termux-app-store help

# Cek list package (harus muncul daftar package)
termux-app-store list
```

---

## Verifikasi SHA256 (Untuk Binary)

Selalu verifikasi checksum binary sebelum menjalankan:

```bash
# Download SHA256SUMS dari release
curl -L https://github.com/djunekz/termux-app-store/releases/latest/download/SHA256SUMS -o SHA256SUMS

# Verifikasi
sha256sum -c SHA256SUMS
```

Output `OK` berarti binary tidak dimodifikasi.

---

## Setelah Instalasi

- Jalankan `termux-app-store` untuk membuka TUI
- Baca [Quick Start](Quick-Start) untuk panduan pertama kali
- Lihat [CLI Reference](CLI-Reference) untuk semua perintah

---

## Masalah saat Install?

Lihat [Troubleshooting](Troubleshooting) atau buka [Issue](https://github.com/djunekz/termux-app-store/issues).
