<div align="center">
</br>
  <img src=".assets/0.jpeg" width="400">
</br>
</div>

<div align="center">
  <h1>
  Termux App Store
  </h1>
  
  [![Community Ready](https://img.shields.io/badge/Community-Ready-2ea44f?style=for-the-badge&logo=github)](https://github.com/djunekz/termux-app-store)
</div>

This project follows community-driven standards including:
- Public contribution workflows
- TUI and CLI interface 
- Automated CI/CD pipelines
- Issue & pull request templates
Transparent release and changelog process

<div>
  <p align ="center">
    <img alt="CI" src="https://github.com/djunekz/termux-app-store/actions/workflows/build.yml/badge.svg"/></a>
    <img alt="Codecov" src="https://codecov.io/github/djunekz/termux-app-store/branch/master/graph/badge.svg?&token=357W4EP8G0" href="https://codecov.io/github/djunekz/termux-app-store"/></a><br>
    <img alt="Version" src="https://img.shields.io/github/v/release/djunekz/termux-app-store.svg?style=for-the-badge&logo=iterm2&color=green" href="ttps://github.com/djunekz/termux-app-store/releases"/>
    <img alt="Download" src="https://img.shields.io/github/downloads/djunekz/termux-app-store/total?style=for-the-badge&logo=abdownloadmanager&logoColor=white&color=green" href="https://github.com/djunekz/termux-app-store"/>
    <img alt="License" src="https://img.shields.io/github/license/djunekz/termux-app-store.svg?style=for-the-badge&logo=homepage&logoColor=white&color=green" href="https://github.com/djunekz/termux-app-store/blob/master/LICENSE"/><br>
    <img alt="Stars" src="https://img.shields.io/github/stars/djunekz/termux-app-store?logo=starship&color=green&logoColor=black"/>
    <img alt="Forks" src="https://img.shields.io/github/forks/djunekz/termux-app-store?logo=refinedgithub&color=green"/><br>
    <img alt="Issues" src="https://img.shields.io/github/issues/djunekz/termux-app-store?style=for-the-badge&logo=openbugbounty&logoColor=white&color=green"/>
    <img alt="Pull Request" src="https://img.shields.io/github/issues-pr/djunekz/termux-app-store?style=for-the-badge&logo=git&logoColor=white&color=green"/>
    <img alt="Contributors" src="https://img.shields.io/github/contributors/djunekz/termux-app-store?style=for-the-badge&logo=github&logoColor=white&color=green"/>

</div>

> 🧠 **Offline-first • Source-based • Binary-safe • Termux-native**

**Termux App Store** adalah **TUI (Terminal User Interface)** berbasis **Textual (Python)** dan CLI yang memungkinkan pengguna Termux untuk **menelusuri, membangun, dan mengelola aplikasi** dari skrip build secara lokal — tanpa akun, tanpa telemetry, dan tanpa ketergantungan cloud.

> ℹ️ **Catatan penting**
> Termux App Store **bukan repository biner terpusat** dan **bukan installer otomatis tersembunyi**.  
> Semua build dijalankan **secara lokal, transparan, dan atas kendali penuh pengguna**.

---

## 👥 Who Is This For?

- Pengguna Termux yang ingin **kontrol penuh atas build**
- Developer yang mendistribusikan tool via **source-based packaging**
- Reviewer & auditor build script
- Maintainer yang mengelola banyak package Termux

---

<div align="center">
  <h1>
📱Tools Interface / Screenshots
  </h1>
</div>

Feature:
> User friendly and
> Touchscreen Support

<div>
  <p align="middle">
    <img src=".assets/0.jpeg" width="74%" /></br>
    <img src=".assets/0main.jpg" width=24% />
    <img src=".assets/1install.jpg" width=24% />
    <img src=".assets/2pallete.jpg" width=24% />
  </p>
</div>

<div align="center">
  
### Menu Interface
![Main Interface](.assets/0main.jpg)

### Install Interface
![Install Interface](.assets/1install.jpg)

### Menu Pallete Interface
![Menu Pallete Interface](.assets/2pallete.jpg)

</div>
  
---

## 🖥️ Perintah Termux App Store

### TUI Commands:
- `termux-app-store` # Menjalankan TUI Interface

### CLI Commands:
- `termux-app-store` _# Menjalankan TUI_
- `termux-app-store` `list` _# Daftar semua package_
- `termux-app-store` `show` `<package>` _# Lihat detail package_
- `termux-app-store` `install` `<package>` _# Build/install package_
- `termux-app-store` `update` _# Update index package_
- `termux-app-store` `upgrade` _# Upgrade semua package_
- `termux-app-store` `upgrade` `<package>` _# Upgrade package tertentu_
- `termux-app-store` `version` _# Cek versi termux app store terbaru_
- `termux-app-store` `help` _# Bantuan / daftar command_

---

## ✨ Fitur Utama

- 📦 **Package Browser (TUI)**  
  Jelajahi paket berbasis folder `packages/` secara interaktif

- 🧠 **Smart Build Validator**
  - Deteksi dependency tidak didukung Termux
  - Badge `UNSUPPORTED`, `UPDATE`, `INSTALLED`, `NEW`

- 🔍 **Search & Filter**
  Cari paket berdasarkan nama atau deskripsi secara real-time

- ⚙️ **One-Click Build**
  Install / update paket via `build-package.sh`

- ⚙️ **One-Click Checker Validation**
  Cek validasi package yang ingin di distribusikan via `./termux-build`

- ⚙️ **One-Click Install / Update / Uninstall Termux App Store**
  Install / update / Uninstall file termux-app-store via `./tasctl`

- 🧩 **Portable Execution**
  Dapat dijalankan dari direktori mana pun selama folder `termux-app-store/packages` tersedia

- 🧬 **Binary Release Ready**
  Source Python tersembunyi di balik binary (PyInstaller / Nuitka)

- 🧠 **Self-Healing Path Resolver**
  Auto-detect lokasi app meski folder dipindah atau di-rename

- 🔐 **Privacy-First**
  Tanpa akun, tanpa tracking, tanpa telemetry

---

## 🧱 Arsitektur
Detail lengkap: [ARCHITECTURE.md](ARCHITECTURE.md)

---

## 🚀 Instalasi (Binary Release)

### Install via Installer (Disarankan)

```bash
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh
```
Lalu jalankan:
```
termux-app-store
```
Atau:
```
termux-app-store -h
```

---

## 🧠 Cara Kerja
1. Aplikasi mencari folder `termux-app-store/packages`
2. Membaca metadata dari `build.sh`
3. Menampilkan paket Termux App Store di TUI atau CLI
4. Menjalankan build via `build-package.sh`
5. Menampilkan log & progress real-time

---

## 🧩 Struktur Package
Setiap package **WAJIB** memiliki:
```
packages/<name_tool>/build.sh
```
Contoh isi minimal file `build.sh`:
```.Text
TERMUX_PKG_HOMEPAGE=
TERMUX_PKG_DESCRIPTION=""
TERMUX_PKG_LICENSE=""
TERMUX_PKG_MAINTAINER="@author-repository"
TERMUX_PKG_VERSION=
TERMUX_PKG_SRCURL=
TERMUX_PKG_SHA256=
```
Contoh file `build.sh`:
berada di folder `template/build.sh`
atau bisa ketik di command `./termux-build template`

---

## 🛠️ termux-build (Check-only Tool)
**termux-build** adalah tool validasi & reviewer helper, BUKAN tool upload atau publish.
Contoh perintah:
- `./termux-build lint <packages/nama_package>`
atau `./termux-build lint <package>`
- `./termux-build check-pr <package>`
- `./termux-build doctor`
- `./termux-build suggest <package>`
- `./termux-build explain <package>`
- `./termux-build template`
- `./termux-build guide`

### Prinsip utama:
- ❌ Tidak mengubah file
- ❌ Tidak build otomatis
- ❌ Tidak upload ke GitHub
- ✅ Hanya membaca & memvalidasi
- Tool ini dirancang untuk:
  - Contributor
  - Reviewer
  - Maintainer
  - CI check
  - User distribution package

---

## 🔴 Badge Status
- 🟢 NEW - Paket baru (<7 hari)
- 🟡 UPDATE - Versi tersedia lebih baru
- 🟢 INSTALLED - Versi sudah terpasang
- 🔴 UNSUPPORTED - Dependency tidak tersedia di Termux

---

## 🔐 Keamanan
- Tidak meminta permission tambahan
- Tidak membuka port
- Tidak menjalankan service background
- Build dijalankan atas perintah user
Detail lengkap: [SECURITY.md](SECURITY.md)

---

## 🛡️ Privasi
- Tanpa akun
- Tanpa analytics
- Tanpa telemetry
- Offline-first
Detail lengkap: [PRIVACY.md](PRIVACY.md)

---

## 🧪 Binary Disclaimer
Binary release:
- Dibangun dari source publik
- Tidak dimodifikasi pasca-build
- Dianjurkan verifikasi checksum
Detail lengkap: [DISCLAIMER.md](DISCLAIMER.md)

---

## 🤝 Kontribusi
Kontribusi sangat diterima!
- Tambah package
- Perbaiki build script
- Audit security
- Perbaiki dokumentasi
- Review PR (Pull Request)
Panduan: [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 📜 Lisensi
Proyek ini dilisensikan di bawah:
**MIT License**
Lihat file [LICENSE](LICENSE)

---

## ❓ FAQ & Bantuan
- **FAQ**: [disini](FAQ.md)
- **TROUBLESHOOTING**: [disini](TROUBLESHOOTING.md)
- **HOW TO UPLOAD**: [disini](HOW_TO_UPLOAD.md)
- **SUPPORT**: [disini](SUPPORT.md)

---

## 🧠 Filosofi
> “Local first. Control over convenience. Transparency over magic.”
Termux App Store dibuat untuk pengguna yang ingin:
- Memahami apa yang dijalankan
- Mengontrol build dan source
- Menghindari vendor lock-in
- Mengupload tool buatannya ke termux-app-store supaya bisa dipakai oleh public
- Mendownload tool termux yang telah didistribusikan ke termux-app-store

---

## 📦 Cara Upload Tool
Upload tool ke Termux App Store dibuat untuk:
- Tool diunduh banyak orang
- Keuntungan bagi yang punya tool di Termux App Store:
  - Update tool hanya mengubah (*version dan sha256*) di file build.sh
- **Cara upload tool ke Termux App Store**:
  - klik dan baca [HOW_TO_UPLOAD](HOW_TO_UPLOAD.md)

---

## 👤 Maintainer / Developer
Independent Developer and Official Developer:
- Djunekz
- Github : [https://github.com/djunekz](https://github.com/djunekz)

---

## ⭐ Dukungan
Jika proyek ini berguna dan membantu:
- ⭐ Star repo
- 🧩 Bagikan ke publik
- 🐛 Laporkan issue
- 🔀 Kirim PR (Pull Request)

© Termux App Store — Built tools for everyone.
