# 📅 Changelog

Riwayat perubahan Termux App Store.

> Untuk changelog lengkap dan terbaru, lihat [CHANGELOG.md](https://github.com/djunekz/termux-app-store/blob/master/CHANGELOG.md) di repository.

---

## v0.1.2 — Latest (Feb 10, 2026)

### Added
- Binary release untuk aarch64, arm, x86_64, i686, universal
- SHA256SUMS untuk semua binary release
- `build-bin.sh` untuk build binary multi-arsitektur

### Fixed
- Perbaikan path resolver di beberapa edge case
- Warning `apt stable CLI interface` dikurangi

### Changed
- Dokumentasi README diperbarui
- CI pipeline dioptimasi

---

## v0.1.1

### Added
- TUI interface berbasis Textual
- Badge status: NEW, UPDATE, INSTALLED, UNSUPPORTED
- Search real-time di TUI
- `termux-build` validation tool
- `tasctl` untuk manajemen instalasi TAS

### Fixed
- Berbagai bug fix di build engine

---

## v0.1.0 — Initial Release

### Added
- Package browser TUI dasar
- CLI commands: list, show, install, update, upgrade
- `build-package.sh` build engine
- `install.sh` installer
- Struktur package dengan `build.sh`
- SHA256 verification
- Self-healing path resolver
- Komunitas: CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, PRIVACY

---

## Format Changelog

Format mengikuti [Keep a Changelog](https://keepachangelog.com/):

- `Added` — Fitur baru
- `Changed` — Perubahan pada fitur yang ada
- `Deprecated` — Fitur yang akan dihapus
- `Removed` — Fitur yang dihapus
- `Fixed` — Perbaikan bug
- `Security` — Perbaikan keamanan

---

## Lihat Juga

- [CHANGELOG.md](https://github.com/djunekz/termux-app-store/blob/master/CHANGELOG.md) — versi lengkap
- [Releases](https://github.com/djunekz/termux-app-store/releases) — semua release
