# Cara Upload File (Package) ke Repository
Berikut langkah umum untuk meng-upload tool/package ke repository Termux App Store:

## 1. Fork Repository
- Buka repository tujuan
- Klik tombol `Fork` (gambar garpu) yang ada di atas
- Pastikan nama repositorinya `termux-app-store`
- Klik `Create fork`

## 2. Clone Repository
```Bash
git clone https://github.com/USERNAME_KAMU/termux-app-store.git
cd termux-app-store
```
`USERNAME_KAMU` = ganti dengan username kamu

## 3. Buat Branch Baru
```Bash
git checkout -b <nama-package>
```
Contoh:
```Bash
git checkout -b contoh
```

## 4. Buat Folder Package
Struktur umum:
```Text
packages/<nama-package>/
             └── build.sh
```
Contoh:
```Bash
mkdir -p packages/contoh
nano packages/contoh/build.sh
```

## 5. Isi build.sh
- Gunakan template build.sh yang ada di folder `template`
- atau bisa menggunakan command `./termux-build template`

- Wajib ada metadata:
 - TERMUX_PKG_HOMEPAGE=
 - TERMUX_PKG_DESCRIPTION=""
 - TERMUX_PKG_LICENSE=""
 - TERMUX_PKG_MAINTAINER=""
 - TERMUX_PKG_VERSION=
 - TERMUX_PKG_SRCURL=
 - TERMUX_PKG_SHA256=

## 6. Validasi Package
Jalankan pengecekan sebelum commit:
```Bash
./termux-build lint packages/<nama-package>
./termux-build doctor
./termux-build check-pr <nama-package>
```
Pastikan tidak ada error ❌.

## 7. Commit Perubahan
```Bash
git add packages/<nama-package>
git commit -m "New package: <nama-package>"
```
Contoh:
```Text
git add packages/contoh
git commit -m "New package: contoh"
```

## 8. Push ke Fork
```Bash
git push origin <nama-package>
```
Contoh:
```Text
git push origin contoh
```
nanti akan muncul link untuk proses Pull Request (PR)

## 9. Buat Pull Request (PR)
- Buka fork kamu di GitHub
- Klik Compare & Pull Request
- Jelaskan singkat:
 - Fungsi tool
 - Sumber upstream
 - Cara build/test (jika perlu)

## 10. Tunggu Review
- Reviewer mungkin meminta revisi
- Jika diminta perubahan:
 - Edit file
 - Commit ulang
 - Push → PR otomatis ter-update

**Catatan Penting**
- `termux-build` hanya untuk check & review,
tidak mengubah file atau upload ke GitHub
- Jangan upload binary hasil build
- Pastikan source berasal dari upstream resmi
