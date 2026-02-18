# 🤝 Contributing Guide

Panduan lengkap untuk berkontribusi ke Termux App Store.

---

## Cara Berkontribusi

Ada banyak cara untuk berkontribusi, tidak harus coding:

| Cara | Cocok untuk |
|---|---|
| 📦 Tambah package baru | Developer yang punya tool Termux |
| 🐛 Laporkan bug | Semua pengguna |
| 🔀 Fix bug via PR | Developer |
| 📖 Perbaiki dokumentasi | Siapa saja |
| 🔍 Review PR orang lain | Yang sudah familiar dengan proyek |
| 🔐 Audit keamanan | Security researcher |
| ⭐ Star & share repo | Siapa saja |

---

## Sebelum Mulai

1. Baca [Code of Conduct](Code-of-Conduct)
2. Cek [Issues yang sudah ada](https://github.com/djunekz/termux-app-store/issues) — mungkin sudah ada yang sedang dikerjakan
3. Untuk perubahan besar, **buka issue dulu** sebelum coding

---

## Setup Development

```bash
# Fork & clone
git clone https://github.com/USERNAME-KAMU/termux-app-store.git
cd termux-app-store

# Install dependencies
apt-get install python git curl
pip install textual

# Jalankan dari source
python termux-app-store.py

# Cek environment
./termux-build doctor
```

---

## Alur Kontribusi

```
1. Fork repo
2. git checkout -b tipe/deskripsi-singkat
3. Buat perubahan
4. Test perubahan
5. git commit -m "tipe: deskripsi"
6. git push origin branch-kamu
7. Buat Pull Request
```

---

## Konvensi Penamaan Branch

```
feat/nama-fitur           ← fitur baru
fix/nama-bug              ← perbaikan bug
docs/nama-dokumen         ← perubahan dokumentasi
add/nama-package          ← tambah package baru
update/nama-package-v1.x  ← update versi package
refactor/nama-komponen    ← refaktor kode
```

---

## Konvensi Commit Message

Format: `tipe: deskripsi singkat`

```
feat: tambah fitur search real-time di TUI
fix: perbaiki crash saat packages/ folder kosong
docs: update README dengan contoh penggunaan
add: add baxter v1.2.4
update: baxter v1.2.4 → v1.3.0
refactor: pisahkan metadata parser ke modul tersendiri
ci: tambah validasi SHA256 di workflow
```

---

## Jenis Pull Request

### Tambah Package Baru
Ikuti panduan di [How to Upload a Package](How-to-Upload-a-Package).

Checklist PR package:
- [ ] Folder `packages/nama-package/` dibuat
- [ ] `build.sh` mengisi semua field wajib
- [ ] SHA256 sudah diverifikasi
- [ ] `./termux-build lint` PASS
- [ ] `./termux-build check-pr` PASS
- [ ] Sudah test install lokal

---

### Bug Fix
```bash
# Branch
git checkout -b fix/nama-bug

# Commit
git commit -m "fix: deskripsi bug yang diperbaiki"
```

Checklist PR bug fix:
- [ ] Deskripsi bug yang diperbaiki jelas
- [ ] Ada referensi ke issue (jika ada): `Fixes #123`
- [ ] Sudah ditest
- [ ] Tidak ada breaking change

---

### Fitur Baru
```bash
# Branch
git checkout -b feat/nama-fitur

# Commit
git commit -m "feat: deskripsi fitur baru"
```

Checklist PR fitur:
- [ ] Ada issue/diskusi sebelumnya untuk fitur ini
- [ ] Dokumentasi diupdate jika perlu
- [ ] Sudah ditest secara manual

---

## Code Style

### Python (TUI/Core)
- Ikuti PEP 8
- Gunakan type hints
- Docstring untuk fungsi publik
- Nama variabel deskriptif

### Bash (build scripts)
- `set -e` di awal script
- Quote semua variabel: `"$VAR"` bukan `$VAR`
- Fungsi dengan nama deskriptif
- Komentar untuk bagian kompleks
- Gunakan `apt-get` bukan `apt` di dalam script

---

## Review Process

Setelah PR dibuat:

1. **CI otomatis** berjalan dalam beberapa menit
2. **Maintainer** akan review dalam 1-3 hari
3. Mungkin ada request for changes — perbaiki dan push ulang
4. Setelah approved → Merge

Tips agar PR cepat di-review:
- PR kecil dan fokus (satu hal per PR)
- Deskripsi PR jelas
- Semua CI check harus hijau
- Respond to review comments dengan cepat

---

## Lihat Juga

- [How to Upload a Package](How-to-Upload-a-Package) — khusus untuk menambah package
- [Code of Conduct](Code-of-Conduct) — aturan komunitas
- [Governance](Governance) — struktur keputusan proyek
