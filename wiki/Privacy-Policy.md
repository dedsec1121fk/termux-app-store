# 🛡️ Privacy Policy

Komitmen privasi Termux App Store.

---

## Zero Telemetry

Termux App Store **tidak mengumpulkan data apapun**:

| Data | Dikumpulkan? |
|---|---|
| Package yang diinstall | ❌ Tidak |
| Frekuensi penggunaan | ❌ Tidak |
| Device information | ❌ Tidak |
| IP address | ❌ Tidak |
| Lokasi | ❌ Tidak |
| Crash reports | ❌ Tidak (kecuali kamu kirim manual) |

---

## Koneksi Jaringan

TAS hanya melakukan koneksi internet untuk:

1. **Download source package** — ke URL yang tertulis di `TERMUX_PKG_SRCURL` (bisa kamu baca di `build.sh`)
2. **Update index** — ke GitHub repo (opsional, atas perintah kamu)

Tidak ada koneksi ke server TAS, tidak ada "call home".

---

## Tanpa Akun

TAS tidak membutuhkan:
- Akun apapun
- Login / registrasi
- Email
- Nomor telepon

---

## Offline-First

Semua fungsi utama TAS berjalan secara offline:
- Browse package list → offline
- Lihat detail package → offline
- Validasi package → offline

Hanya install/update yang butuh internet (untuk download source).

---

## Data Lokal

Data yang disimpan di perangkat kamu:
- Folder `packages/` — metadata package (dari GitHub clone)
- Binary/script yang terinstall — di `$PREFIX/bin/`
- Log output di terminal (tidak disimpan ke file kecuali kamu redirect)

---

## Lihat Juga

- [Security Policy](Security-Policy)
- [Architecture Overview](Architecture-Overview)
