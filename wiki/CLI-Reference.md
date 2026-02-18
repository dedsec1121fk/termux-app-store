# 📟 CLI Reference

Referensi lengkap semua perintah CLI Termux App Store.

---

## Sintaks Dasar

```
termux-app-store [perintah] [argumen] [opsi]
```

---

## Daftar Perintah

### `termux-app-store` _(tanpa argumen)_
Membuka antarmuka TUI interaktif.

```bash
termux-app-store
```

---

### `list`
Menampilkan semua package yang tersedia di store.

```bash
termux-app-store list
```

**Output contoh:**
```
📦 Available Packages (12 total)
─────────────────────────────────────────
  baxter          v1.2.4    🟢 NEW
  zora            v1.0.0    🟡 UPDATE
  mytool          v2.1.0    🟢 INSTALLED
  legacytool      v0.9.0    🔴 UNSUPPORTED
─────────────────────────────────────────
```

**Badge status:**
| Badge | Arti |
|---|---|
| 🟢 `NEW` | Dirilis < 7 hari |
| 🟡 `UPDATE` | Versi baru tersedia |
| 🟢 `INSTALLED` | Sudah terpasang & up-to-date |
| 🔴 `UNSUPPORTED` | Dependency tidak tersedia di Termux |

---

### `show <package>`
Menampilkan detail lengkap sebuah package.

```bash
termux-app-store show baxter
```

**Output contoh:**
```
╔══════════════════════════════════════╗
║  Package  : baxter                  ║
║  Version  : 1.2.4                   ║
║  License  : MIT                     ║
║  Maintainer: @djunekz               ║
║  Homepage : https://github.com/...  ║
║  Description:                       ║
║    Tool untuk otomasi Termux        ║
╚══════════════════════════════════════╝
```

---

### `install <package>`
Build dan install package dari source.

```bash
termux-app-store install baxter
# Singkatan:
termux-app-store i baxter
```

**Proses yang terjadi:**
1. Baca metadata dari `build.sh`
2. Resolve & install dependencies via `apt-get`
3. Download source sesuai `TERMUX_PKG_SRCURL`
4. Verifikasi SHA256
5. Build & install
6. Tampilkan log real-time

**Output contoh:**
```
[*] Installing baxter v1.2.4...
  ======================================================================
                        Termux App Store Builder
                  github.com/djunekz/termux-app-store
  ======================================================================
    :: System & Architecture
  ----------------------------------------------------------------------
      Package :   baxter
      Version :   1.2.4
      Arch    :   aarch64
      Prefix  :   /data/data/com.termux/files/usr
    :: Dependencies
  ----------------------------------------------------------------------
    [  OK  ]  All dependencies satisfied
    :: Build
  ----------------------------------------------------------------------
    [  OK  ]  SHA256 verified
    [  OK  ]  Build complete
    [  OK  ]  baxter v1.2.4 installed successfully!
```

---

### `update`
Update index/daftar package dari repository.

```bash
termux-app-store update
```

> Jalankan ini sebelum `upgrade` untuk memastikan data package terbaru.

---

### `upgrade`
Upgrade semua package yang terinstall ke versi terbaru.

```bash
# Upgrade semua package
termux-app-store upgrade

# Upgrade satu package spesifik
termux-app-store upgrade baxter
```

---

### `search <kata-kunci>`
Cari package berdasarkan nama atau deskripsi.

```bash
termux-app-store search scanner
termux-app-store search "network tool"
```

---

### `remove <package>`
Uninstall/hapus package yang sudah terinstall.

```bash
termux-app-store remove baxter
# Atau:
termux-app-store uninstall baxter
```

---

### `version`
Menampilkan versi Termux App Store yang terpasang dan cek apakah ada update.

```bash
termux-app-store version
```

**Output contoh:**
```
Termux App Store v0.1.2
Latest  : v0.1.2  ✓ Up to date
```

---

### `help`
Menampilkan daftar semua perintah yang tersedia.

```bash
termux-app-store help
termux-app-store -h
termux-app-store --help
```

---

## Opsi Global

| Opsi | Fungsi |
|---|---|
| `-h`, `--help` | Tampilkan bantuan |
| `--version` | Tampilkan versi |
| `--no-color` | Nonaktifkan warna output |
| `--verbose` | Output lebih detail |
| `--quiet` | Minimalkan output |

---

## Contoh Penggunaan Umum

```bash
# Lihat semua package lalu install yang diinginkan
termux-app-store list
termux-app-store install zora

# Cari package scanner lalu lihat detailnya
termux-app-store search scanner
termux-app-store show zora

# Update index lalu upgrade semua
termux-app-store update
termux-app-store upgrade

# Cek versi TAS
termux-app-store version
```

---

## Lihat Juga

- [TUI Guide](TUI-Guide) — panduan antarmuka visual
- [Package Management](Package-Management) — alur lengkap manajemen package
- [Troubleshooting](Troubleshooting) — solusi error umum
