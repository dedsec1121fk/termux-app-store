# 📤 How to Upload a Package

Panduan lengkap cara menambahkan tool kamu ke Termux App Store.

---

## Mengapa Upload ke Termux App Store?

- 🌍 Tool kamu bisa diinstall oleh semua pengguna Termux
- 🔄 Update semudah mengubah `version` dan `sha256` di `build.sh`
- 🔍 Mudah ditemukan lewat search di TUI/CLI
- 🤝 Berkontribusi ke komunitas Termux

---

## Alur Upload (Overview)

```
1. Fork repo  →  2. Buat folder package  →  3. Tulis build.sh
       ↓
4. Validasi  →  5. Commit & Push  →  6. Buat Pull Request
       ↓
7. Review oleh maintainer  →  8. Merge  →  9. Package live!
```

---

## Step 1 — Fork Repository

Kunjungi [github.com/djunekz/termux-app-store](https://github.com/djunekz/termux-app-store) lalu klik **Fork**.

```bash
# Clone fork kamu
git clone https://github.com/USERNAME-KAMU/termux-app-store.git
cd termux-app-store
```

---

## Step 2 — Buat Branch Baru

```bash
git checkout -b add-package-nama-tool
```

---

## Step 3 — Buat Folder Package

```bash
mkdir -p packages/nama-tool
```

Aturan nama folder:
- Huruf kecil semua
- Gunakan tanda hubung `-` bukan underscore `_`
- Tidak boleh spasi
- Contoh: `my-awesome-tool`, `baxter`, `zora-scanner`

---

## Step 4 — Buat file `build.sh`

```bash
# Cara 1: Generate template otomatis
./termux-build template nama-tool

# Cara 2: Copy dari template manual
cp template/build.sh packages/nama-tool/build.sh
```

Edit `packages/nama-tool/build.sh`:

```bash
TERMUX_PKG_HOMEPAGE="https://github.com/kamu/nama-tool"
TERMUX_PKG_DESCRIPTION="Deskripsi singkat tool kamu (maks 80 karakter)"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@github-username-kamu"
TERMUX_PKG_VERSION="1.0.0"
TERMUX_PKG_SRCURL="https://github.com/kamu/nama-tool/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="<sha256-hash-file-source>"
TERMUX_PKG_DEPENDS=""   # isi jika butuh dependency
```

---

## Step 5 — Dapatkan SHA256

```bash
# Download source dulu
curl -L "https://github.com/kamu/nama-tool/archive/refs/tags/v1.0.0.tar.gz" -o source.tar.gz

# Ambil SHA256
sha256sum source.tar.gz

# Output: abc123def456...  source.tar.gz
# Copy hash tersebut ke TERMUX_PKG_SHA256
```

---

## Step 6 — Validasi Package

**Wajib** sebelum membuat PR:

```bash
# Lint package kamu
./termux-build lint packages/nama-tool

# Cek kesiapan PR
./termux-build check-pr nama-tool

# Lihat saran perbaikan
./termux-build suggest nama-tool
```

Semua check harus **PASS** sebelum lanjut.

---

## Step 7 — Commit & Push

```bash
git add packages/nama-tool/
git commit -m "feat: add nama-tool v1.0.0

- Short description of the tool
- Maintainer: @github-username"

git push origin add-package-nama-tool
```

---

## Step 8 — Buat Pull Request

1. Buka repo fork kamu di GitHub
2. Klik **Compare & pull request**
3. Isi judul: `feat: add nama-tool v1.0.0`
4. Isi deskripsi sesuai template PR yang tersedia
5. Submit PR

**Template deskripsi PR:**
```markdown
## Package Information
- **Name:** nama-tool
- **Version:** 1.0.0
- **License:** MIT
- **Homepage:** https://github.com/kamu/nama-tool

## Checklist
- [ ] build.sh mengisi semua field wajib
- [ ] SHA256 sudah diverifikasi
- [ ] ./termux-build lint PASS
- [ ] ./termux-build check-pr PASS
- [ ] Sudah test install secara lokal
- [ ] Nama package lowercase dengan tanda hubung
```

---

## Step 9 — Review Process

Setelah PR dibuat:

1. **CI otomatis** akan menjalankan `./termux-build check-pr`
2. **Maintainer** akan mereview dalam beberapa hari
3. Jika ada revisi, kamu akan diminta untuk memperbaiki
4. Setelah approved → **Merge** → package kamu **live**!

---

## Update Versi Package

Ketika tool kamu rilis versi baru:

```bash
# 1. Buat branch baru
git checkout -b update-nama-tool-v1.1.0

# 2. Edit build.sh — ubah VERSION dan SHA256
nano packages/nama-tool/build.sh

# 3. Update field:
# TERMUX_PKG_VERSION="1.1.0"
# TERMUX_PKG_SHA256="hash-baru"

# 4. Validasi
./termux-build lint packages/nama-tool

# 5. Commit & PR
git add packages/nama-tool/build.sh
git commit -m "update: nama-tool v1.0.0 → v1.1.0"
git push origin update-nama-tool-v1.1.0
```

---

## Yang TIDAK Boleh di Package

| Larangan | Alasan |
|---|---|
| Malware / backdoor | Keamanan pengguna |
| Duplicate package (sudah ada di Termux official) | Confusing |
| Binary pre-compiled di folder packages | Must be source-based |
| Package tanpa SHA256 | Keamanan |
| Tool yang melanggar hukum | Kebijakan komunitas |

---

## Tips

- **Uji lokal dulu** sebelum PR: `termux-app-store install ./packages/nama-tool`
- **SHA256 harus akurat** — kalau salah, instalasi akan gagal
- **Deskripsikan dengan jelas** — bantu pengguna memahami kegunaan tool
- **Selalu test di Termux nyata**, bukan hanya di emulator

---

## Lihat Juga

- [Package Structure](Package-Structure) — aturan struktur package
- [Build Script Reference](Build-Script-Reference) — semua variabel build.sh
- [termux-build Tool](termux-build-Tool) — cara pakai validator
- [Contributing Guide](Contributing-Guide) — panduan kontribusi lengkap
