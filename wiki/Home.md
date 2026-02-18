# 📚 Termux App Store — Wiki

Selamat datang di Wiki resmi **Termux App Store** — package manager offline-first berbasis TUI & CLI untuk Termux.

---

## 🗂️ Daftar Isi Wiki

### 🚀 Memulai
| Halaman | Deskripsi |
|---|---|
| [Installation](Installation) | Cara install Termux App Store |
| [Quick Start](Quick-Start) | Panduan cepat pertama kali pakai |
| [Uninstallation](Uninstallation) | Cara uninstall bersih |

### 📖 Penggunaan
| Halaman | Deskripsi |
|---|---|
| [TUI Guide](TUI-Guide) | Panduan lengkap antarmuka TUI |
| [CLI Reference](CLI-Reference) | Semua perintah CLI beserta contoh |
| [Package Management](Package-Management) | Browse, install, update, upgrade package |

### 📦 Package & Kontribusi
| Halaman | Deskripsi |
|---|---|
| [Package Structure](Package-Structure) | Struktur wajib setiap package |
| [How to Upload a Package](How-to-Upload-a-Package) | Cara submit package kamu ke store |
| [Build Script Reference](Build-Script-Reference) | Semua variabel `build.sh` dijelaskan |
| [termux-build Tool](termux-build-Tool) | Panduan tool validasi & lint |

### 🏗️ Arsitektur & Teknis
| Halaman | Deskripsi |
|---|---|
| [Architecture Overview](Architecture-Overview) | Cara kerja internal TAS |
| [Build System](Build-System) | Penjelasan `build-package.sh` |
| [Binary Release](Binary-Release) | Proses build binary multi-arsitektur |
| [tasctl Reference](tasctl-Reference) | Panduan manajemen instalasi TAS |

### 🔐 Keamanan & Privasi
| Halaman | Deskripsi |
|---|---|
| [Security Policy](Security-Policy) | Kebijakan keamanan proyek |
| [Privacy Policy](Privacy-Policy) | Komitmen privasi & zero telemetry |
| [SHA256 Verification](SHA256-Verification) | Cara verifikasi checksum binary |

### 🤝 Komunitas
| Halaman | Deskripsi |
|---|---|
| [Contributing Guide](Contributing-Guide) | Panduan lengkap kontribusi |
| [Code of Conduct](Code-of-Conduct) | Aturan komunitas |
| [Governance](Governance) | Struktur keputusan proyek |
| [FAQ](FAQ) | Pertanyaan yang sering ditanyakan |
| [Troubleshooting](Troubleshooting) | Solusi masalah umum |
| [Changelog](Changelog) | Riwayat perubahan versi |

---

## ⚡ Quick Links

```bash
# Install
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash

# Jalankan TUI
termux-app-store

# Lihat semua package
termux-app-store list

# Install package
termux-app-store install <nama-package>
```

---

## 💡 Filosofi Proyek

> *"Local first. Control over convenience. Transparency over magic."*

- **Offline-first** — tidak butuh koneksi untuk mengelola package
- **Source-based** — kamu tahu persis apa yang dijalankan
- **Privacy-first** — tanpa akun, tanpa telemetry, tanpa tracking
- **Community-driven** — dibangun untuk dan oleh komunitas Termux

---

## 👤 Maintainer

**Djunekz** — [github.com/djunekz](https://github.com/djunekz)

© Termux App Store — MIT License
