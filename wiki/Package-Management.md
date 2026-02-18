# 📦 Package Management

Panduan lengkap mengelola package di Termux App Store.

---

## Browse Package

### Via TUI
```bash
termux-app-store
# Scroll dengan ↑↓ atau j/k
# Ketik untuk search real-time
```

### Via CLI
```bash
# Lihat semua package
termux-app-store list

# Cari package
termux-app-store search scanner

# Detail satu package
termux-app-store show baxter
```

---

## Install Package

```bash
# Install satu package
termux-app-store install baxter

# Singkatan
termux-app-store i baxter
```

Proses install:
1. Baca `build.sh`
2. Install dependencies via `apt-get install`
3. Download source dari `TERMUX_PKG_SRCURL`
4. Verifikasi SHA256
5. Build & install
6. Konfirmasi sukses

---

## Update & Upgrade

```bash
# Update index package (ambil data terbaru dari repo)
termux-app-store update

# Upgrade semua package yang terinstall
termux-app-store upgrade

# Upgrade satu package saja
termux-app-store upgrade baxter
```

---

## Remove Package

```bash
termux-app-store remove baxter
# atau
termux-app-store uninstall baxter
```

---

## Cek Status Package

```bash
# Lihat detail termasuk status
termux-app-store show baxter

# Output:
# Package : baxter
# Version : 1.2.4
# Installed: 1.2.4 (up to date)
# Status  : 🟢 INSTALLED
```

---

## Badge Status

| Badge | Arti | Aksi yang Disarankan |
|---|---|---|
| 🟢 `NEW` | Baru dirilis < 7 hari | Coba install jika tertarik |
| 🟡 `UPDATE` | Versi baru tersedia | Jalankan `upgrade` |
| 🟢 `INSTALLED` | Sudah up-to-date | Tidak perlu aksi |
| 🔴 `UNSUPPORTED` | Dependency tidak tersedia | Tidak bisa diinstall |

---

## Lihat Juga

- [CLI Reference](CLI-Reference) — semua perintah lengkap
- [TUI Guide](TUI-Guide) — panduan antarmuka visual
- [Troubleshooting](Troubleshooting) — solusi masalah install
