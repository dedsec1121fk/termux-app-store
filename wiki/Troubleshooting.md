# 🔧 Troubleshooting

Solusi untuk masalah umum yang sering ditemui saat menggunakan Termux App Store.

---

## Masalah Instalasi

### ❌ `command not found: termux-app-store`

**Penyebab:** TAS belum ada di PATH.

**Solusi:**
```bash
# Cek apakah binary ada
ls $PREFIX/bin/termux-app-store

# Jika tidak ada, jalankan installer ulang
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash

# Atau tambahkan PATH manual
echo 'export PATH="$HOME/termux-app-store:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

### ❌ `curl: command not found`

```bash
apt-get install curl
```

---

### ❌ `python: command not found`

```bash
apt-get install python
# atau
apt-get install python3
```

---

### ❌ Error saat `pip install`

```bash
# Pastikan pip up to date
pip install --upgrade pip

# Install dengan flag yang diperlukan
pip install textual --break-system-packages
```

---

## Masalah Saat Install Package

### ❌ `SHA256 mismatch — aborting`

**Penyebab:** File yang didownload rusak atau SHA256 di `build.sh` salah.

**Solusi:**
```bash
# Download ulang secara manual
curl -L <TERMUX_PKG_SRCURL> -o source.tar.gz

# Verifikasi SHA256
sha256sum source.tar.gz

# Bandingkan dengan nilai di build.sh
# Jika beda → laporkan sebagai issue di GitHub
```

---

### ❌ `apt does not have a stable CLI interface`

**Penyebab:** Script menggunakan `apt` bukan `apt-get` di dalam script.

**Solusi:** Warning ini **tidak berbahaya**, instalasi tetap berjalan. Tapi jika ingin menghilangkannya, ini masalah di `build-package.sh` yang bisa dilaporkan sebagai issue.

---

### ❌ `E: Unable to locate package <nama>`

**Penyebab:** Package dependency tidak tersedia di repository Termux kamu.

**Solusi:**
```bash
# Update repository dulu
apt-get update

# Coba install manual
apt-get install <nama-package>

# Jika tidak ada, package memiliki badge UNSUPPORTED
# Berarti tidak kompatibel dengan Termux kamu
```

---

### ❌ `Permission denied`

```bash
# Perbaiki permission
chmod +x $PREFIX/bin/termux-app-store

# Atau untuk build-package.sh
chmod +x build-package.sh
```

---

## Masalah TUI

### ❌ TUI tidak tampil / blank screen

**Penyebab 1:** Textual belum terinstall.
```bash
pip install textual
```

**Penyebab 2:** Terminal tidak kompatibel.
```bash
# Coba dengan terminal emulator lain
# atau gunakan mode CLI saja:
termux-app-store list
```

**Penyebab 3:** Ukuran terminal terlalu kecil.
- Perbesar ukuran font atau perkecil zoom di Termux

---

### ❌ Warna/karakter aneh di terminal

```bash
# Set TERM environment
export TERM=xterm-256color
echo 'export TERM=xterm-256color' >> ~/.bashrc
```

---

### ❌ Touch screen tidak responsif di TUI

- Pastikan menggunakan Termux versi terbaru dari **F-Droid**
- Coba swipe lebih lambat
- Gunakan CLI sebagai alternatif

---

## Masalah Package List

### ❌ `packages/ folder not found`

**Penyebab:** Termux App Store tidak menemukan folder packages.

**Solusi:**
```bash
# Cek lokasi instalasi
find $HOME -name "packages" -type d 2>/dev/null | grep termux-app-store

# Install ulang
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash
```

---

### ❌ Daftar package kosong

```bash
# Update index
termux-app-store update

# Cek koneksi internet
curl -I https://github.com

# Atau clone ulang packages
git -C ~/termux-app-store pull
```

---

### ❌ Badge status tidak akurat

```bash
# Refresh cache
termux-app-store update

# Force refresh di TUI
# Tekan F5 atau r di dalam TUI
```

---

## Masalah `termux-build`

### ❌ `./termux-build: Permission denied`

```bash
chmod +x termux-build
./termux-build lint nama-package
```

---

### ❌ `lint` gagal karena SRCURL tidak reachable

**Jika sedang offline:**
```bash
# Gunakan flag offline (jika tersedia)
./termux-build lint --offline nama-package
```

**Jika URL memang salah:** Perbaiki `TERMUX_PKG_SRCURL` di `build.sh`.

---

## Reset & Reinstall

Jika semua solusi di atas tidak berhasil, coba reinstall bersih:

```bash
# Uninstall
bash uninstall.sh
# atau
./tasctl uninstall

# Bersihkan sisa file
rm -rf ~/termux-app-store
rm -f $PREFIX/bin/termux-app-store

# Install ulang
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash
```

---

## Melaporkan Bug

Jika masalah belum terselesaikan:

1. Jalankan `./termux-build doctor` dan copy outputnya
2. Buka [GitHub Issues](https://github.com/djunekz/termux-app-store/issues)
3. Klik **New Issue** → pilih template **Bug Report**
4. Isi informasi:
   - Versi TAS: `termux-app-store version`
   - Versi Termux: `termux-info`
   - Arsitektur: `uname -m`
   - Pesan error lengkap
   - Langkah untuk mereproduksi

---

## Lihat Juga

- [FAQ](FAQ) — pertanyaan umum
- [Installation](Installation) — panduan instalasi ulang
- [GitHub Issues](https://github.com/djunekz/termux-app-store/issues) — laporkan bug
