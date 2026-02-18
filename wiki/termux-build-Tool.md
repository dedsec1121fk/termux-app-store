# 🛠️ termux-build Tool

Panduan lengkap menggunakan `termux-build` — validation & reviewer helper tool.

---

## Apa itu termux-build?

`termux-build` adalah tool **read-only** untuk memvalidasi package sebelum didistribusikan. Dirancang untuk contributor, reviewer, maintainer, dan CI/CD pipeline.

**Prinsip utama:**
| | |
|---|---|
| ❌ | Tidak mengubah file apapun |
| ❌ | Tidak build otomatis |
| ❌ | Tidak upload ke GitHub |
| ✅ | Hanya membaca & memvalidasi |
| ✅ | Aman dijalankan kapan saja |

---

## Lokasi File

```bash
./termux-build   # Di root folder termux-app-store
```

Atau jika sudah di PATH:
```bash
termux-build
```

---

## Daftar Perintah

### `lint` — Validasi Build Script

Memeriksa semua field wajib dan format di `build.sh`.

```bash
# Lint satu package (dengan path lengkap)
./termux-build lint packages/baxter

# Lint dengan nama package saja
./termux-build lint baxter
```

**Output contoh (sukses):**
```
🔍 Linting packages/baxter/build.sh...
─────────────────────────────────────────
[✓] TERMUX_PKG_HOMEPAGE    — https://github.com/... (reachable)
[✓] TERMUX_PKG_DESCRIPTION — "Automation tool" (42 chars, OK)
[✓] TERMUX_PKG_LICENSE     — MIT (recognized)
[✓] TERMUX_PKG_MAINTAINER  — @djunekz (valid format)
[✓] TERMUX_PKG_VERSION     — 1.2.4 (SemVer valid)
[✓] TERMUX_PKG_SRCURL      — https://... (reachable)
[✓] TERMUX_PKG_SHA256      — a1b2c3... (64 chars, valid format)
─────────────────────────────────────────
✅ Package valid! Siap untuk PR.
```

**Output contoh (ada error):**
```
🔍 Linting packages/mytool/build.sh...
─────────────────────────────────────────
[✓] TERMUX_PKG_HOMEPAGE    — OK
[✗] TERMUX_PKG_DESCRIPTION — MISSING (field kosong)
[✓] TERMUX_PKG_LICENSE     — OK
[✗] TERMUX_PKG_VERSION     — "v1.0" (bukan SemVer valid, gunakan 1.0.0)
[✗] TERMUX_PKG_SHA256      — "abc123" (terlalu pendek, harus 64 karakter)
─────────────────────────────────────────
❌ 3 error ditemukan. Perbaiki sebelum PR.
```

---

### `check-pr` — Validasi Kesiapan Pull Request

Melakukan pemeriksaan lengkap sebelum submit PR.

```bash
./termux-build check-pr baxter
./termux-build check-pr packages/baxter
```

Pemeriksaan yang dilakukan:
- Semua field wajib terisi
- Format SemVer pada VERSION
- SHA256 valid (64 karakter hex)
- SRCURL dapat diakses
- SHA256 cocok dengan file yang didownload
- Nama package sesuai aturan (lowercase, tanda hubung)
- Tidak ada konflik dengan package yang sudah ada

---

### `doctor` — Cek Environment

Memeriksa apakah environment kamu siap untuk development.

```bash
./termux-build doctor
```

**Output contoh:**
```
🩺 Termux App Store Environment Check
─────────────────────────────────────────
[✓] Termux          — detected
[✓] Python          — 3.11.4
[✓] pip             — 23.2.1
[✓] git             — 2.41.0
[✓] curl            — 7.88.1
[✓] sha256sum       — available
[✓] packages/       — found (12 packages)
[✓] template/       — found
[✓] build-package.sh — found & executable
─────────────────────────────────────────
✅ Environment siap!
```

---

### `suggest` — Saran Perbaikan

Memberikan saran untuk meningkatkan kualitas package.

```bash
./termux-build suggest baxter
```

**Output contoh:**
```
💡 Suggestions for packages/baxter:
─────────────────────────────────────────
[!] TERMUX_PKG_DEPENDS kosong
    → Apakah tool ini benar-benar tidak butuh dependency?
    → Jika butuh Python, tambahkan: TERMUX_PKG_DEPENDS="python"

[!] Tidak ada README.md di folder package
    → Pertimbangkan menambahkan README.md untuk dokumentasi

[!] Homepage tidak memiliki release page
    → Pastikan TERMUX_PKG_SRCURL mengarah ke tagged release
─────────────────────────────────────────
3 saran ditemukan (bukan error, tapi dianjurkan diperbaiki).
```

---

### `explain` — Penjelasan Package

Menampilkan ringkasan lengkap package beserta penjelasannya.

```bash
./termux-build explain baxter
```

**Output contoh:**
```
📦 Package: baxter
─────────────────────────────────────────
Homepage   : https://github.com/djunekz/baxter
Description: Automation tool for Termux power users
License    : MIT
Maintainer : @djunekz
Version    : 1.2.4
Source     : https://github.com/.../v1.2.4.tar.gz
SHA256     : a1b2c3d4...
Dependencies: python, curl

Status: ✅ Valid package
─────────────────────────────────────────
```

---

### `template` — Generate Template build.sh

Membuat file `build.sh` dengan template yang sudah terisi.

```bash
# Generate template kosong
./termux-build template

# Generate template dengan nama package
./termux-build template nama-tool
# Akan membuat: packages/nama-tool/build.sh
```

**Isi template yang dihasilkan:**
```bash
TERMUX_PKG_HOMEPAGE=""
TERMUX_PKG_DESCRIPTION=""
TERMUX_PKG_LICENSE=""
TERMUX_PKG_MAINTAINER="@"
TERMUX_PKG_VERSION=""
TERMUX_PKG_SRCURL=""
TERMUX_PKG_SHA256=""
TERMUX_PKG_DEPENDS=""
```

---

### `guide` — Panduan Kontribusi

Menampilkan panduan singkat cara upload package.

```bash
./termux-build guide
```

---

## Workflow yang Disarankan

Urutan yang benar sebelum submit PR:

```bash
# 1. Cek environment dulu
./termux-build doctor

# 2. Buat template
./termux-build template nama-tool

# 3. Edit build.sh (isi semua field)
nano packages/nama-tool/build.sh

# 4. Lint — cek format
./termux-build lint nama-tool

# 5. Lihat saran perbaikan
./termux-build suggest nama-tool

# 6. Cek kesiapan PR
./termux-build check-pr nama-tool

# 7. Kalau semua PASS → commit & push → buat PR
```

---

## Penggunaan di CI/CD

`termux-build` bisa dijalankan otomatis di GitHub Actions:

```yaml
- name: Validate packages
  run: |
    ./termux-build lint ${{ env.CHANGED_PACKAGE }}
    ./termux-build check-pr ${{ env.CHANGED_PACKAGE }}
```

Exit code:
- `0` — Semua check PASS
- `1` — Ada error yang harus diperbaiki

---

## Lihat Juga

- [Package Structure](Package-Structure) — aturan struktur package
- [How to Upload a Package](How-to-Upload-a-Package) — alur upload lengkap
- [Build Script Reference](Build-Script-Reference) — semua variabel build.sh
