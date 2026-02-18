# 🖥️ TUI Guide

Panduan lengkap menggunakan antarmuka TUI (Terminal User Interface) Termux App Store.

---

## Membuka TUI

```bash
termux-app-store
```

---

## Layout Antarmuka

```
┌─────────────────────────────────────────────────────┐
│  🏪 Termux App Store           [v0.1.2]  [?] Help  │
├─────────────────────────────────────────────────────┤
│  🔍 Search: [________________________]              │
├──────────────────┬──────────────────────────────────┤
│                  │                                  │
│  📦 Package List │  📋 Package Detail               │
│  ─────────────── │  ────────────────────────────── │
│  > baxter  NEW   │  Name    : baxter                │
│    zora    UPD   │  Version : 1.2.4                 │
│    mytool  INST  │  License : MIT                   │
│    oldtool UNSUP │  Size    : ~2.4MB                │
│                  │  Deps    : nodejs, python        │
│                  │  Desc    : Automation tool       │
│                  │                                  │
│                  │  [I] Install   [U] Update        │
│                  │  [R] Remove    [O] Homepage      │
├─────────────────────────────────────────────────────┤
│  Total: 12 packages  |  Installed: 3  |  q: Quit   │
└─────────────────────────────────────────────────────┘
```

---

## Navigasi Keyboard

### Navigasi Umum

| Tombol | Fungsi |
|---|---|
| `↑` / `↓` | Navigasi daftar package |
| `j` / `k` | Navigasi (vim-style) |
| `Enter` | Pilih / konfirmasi |
| `Esc` | Kembali / batalkan |
| `q` | Keluar dari TUI |
| `?` | Tampilkan bantuan |

### Aksi Package

| Tombol | Fungsi |
|---|---|
| `i` | Install package yang dipilih |
| `u` | Update package yang dipilih |
| `r` | Remove/uninstall package |
| `o` | Buka homepage package |
| `Enter` | Lihat detail package |

### Pencarian & Filter

| Tombol | Fungsi |
|---|---|
| `/` | Aktifkan mode search |
| `Esc` | Keluar dari mode search |
| `Tab` | Pindah fokus antar panel |

### Tampilan

| Tombol | Fungsi |
|---|---|
| `F5` atau `r` | Refresh daftar package |
| `f` | Filter berdasarkan status |
| `s` | Sort (nama / versi / status) |

---

## Touch Screen Support

TUI Termux App Store mendukung layar sentuh:

| Gesture | Fungsi |
|---|---|
| **Tap** pada package | Pilih & lihat detail |
| **Double tap** | Install / update package |
| **Swipe up/down** | Scroll daftar package |
| **Tap tombol** `[I]` `[U]` `[R]` | Aksi install/update/remove |

---

## Panel Kiri — Package List

Menampilkan semua package yang tersedia dengan badge status:

- 🟢 **NEW** — Package baru, dirilis kurang dari 7 hari
- 🟡 **UPDATE** — Versi lebih baru tersedia untuk diupgrade
- 🟢 **INSTALLED** — Sudah terinstall dan up-to-date
- 🔴 **UNSUPPORTED** — Dependency tidak tersedia di Termux kamu

---

## Panel Kanan — Package Detail

Menampilkan informasi lengkap package yang sedang dipilih:

- **Name** — Nama package
- **Version** — Versi saat ini di store
- **Installed** — Versi yang terinstall (jika ada)
- **License** — Lisensi package
- **Maintainer** — GitHub username maintainer
- **Homepage** — Link ke repository/homepage
- **Description** — Deskripsi singkat
- **Dependencies** — Daftar dependency yang dibutuhkan
- **Size** — Estimasi ukuran setelah install

---

## Mode Search

Tekan `/` untuk masuk mode search, lalu ketik kata kunci:

```
🔍 Search: [scanner_____________]

Hasil: 3 package ditemukan
  > zora          v1.0.0   🟡 UPDATE
    portscan      v0.5.2   🟢 INSTALLED
    netscan       v1.1.0   🟢 NEW
```

Search bekerja secara **real-time** — daftar langsung difilter saat mengetik, berdasarkan nama dan deskripsi package.

---

## Log & Progress Install

Saat install/update, TUI menampilkan log real-time:

```
Installing baxter v1.2.4...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100%

[✓] Checking dependencies
[✓] nodejs — already installed
[✓] Downloading source...
[✓] SHA256 verified
[✓] Building...
[✓] Installing...
[✓] Done! baxter v1.2.4 installed
```

---

## Keluar dari TUI

```
q       → Keluar langsung
Ctrl+C  → Force quit
Esc     → Kembali ke menu sebelumnya
```

---

## Lihat Juga

- [CLI Reference](CLI-Reference) — gunakan TAS via command line
- [Package Management](Package-Management) — alur manajemen package
