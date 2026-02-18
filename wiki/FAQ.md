# ❓ FAQ — Frequently Asked Questions

---

## Umum

### Apa itu Termux App Store?
Termux App Store (TAS) adalah package manager dengan antarmuka TUI dan CLI untuk Termux. Memungkinkan kamu browse, install, dan update tool-tool Termux dari satu tempat — secara offline, transparan, dan tanpa telemetry.

---

### Apa bedanya TAS dengan `pkg` atau `apt`?
| | `pkg` / `apt` | Termux App Store |
|---|---|---|
| Source | Repo resmi Termux | Community packages |
| Interface | CLI saja | TUI + CLI |
| Build | Binary pre-compiled | Source-based |
| Privacy | Standard | Zero telemetry |
| Offline | Butuh update index | Fully offline-first |

TAS **tidak menggantikan** `pkg` — keduanya bisa dipakai bersamaan.

---

### Apakah TAS gratis?
Ya, 100% gratis dan open source di bawah lisensi MIT.

---

### Apakah butuh koneksi internet?
- Untuk **browse package list**: Tidak perlu (offline-first)
- Untuk **install package**: Ya, untuk download source
- Untuk **update index**: Ya

---

### Apakah perlu akun GitHub untuk pakai TAS?
Tidak. Kamu bisa install dan pakai TAS tanpa akun apapun.

---

## Instalasi

### Termux dari mana yang didukung?
Gunakan Termux dari **F-Droid** — bukan dari Google Play Store. Versi Play Store sudah deprecated dan tidak diupdate lagi.

---

### Apakah bisa dipakai di PC/Linux?
TAS dirancang untuk Termux di Android. Mungkin bisa jalan di Linux biasa, tapi tidak officially supported.

---

### Bagaimana cara update TAS itu sendiri?
```bash
termux-app-store version   # Cek versi saat ini
./tasctl update             # Update TAS ke versi terbaru
```

---

### Bagaimana cara uninstall TAS?
```bash
./tasctl uninstall
# atau
bash uninstall.sh
```

---

## Package

### Bagaimana cara install package?
```bash
termux-app-store install nama-package
# atau singkat:
termux-app-store i nama-package
```

---

### Package saya punya badge UNSUPPORTED — kenapa?
Badge `UNSUPPORTED` muncul ketika dependency yang dibutuhkan package tersebut tidak tersedia di repositori Termux kamu. Ini bisa karena:
- Arsitektur tidak didukung
- Package dependency tidak ada di Termux repo

---

### Apakah aman menginstall package dari TAS?
Semua package di TAS:
- Dibangun dari source publik
- Harus melewati review PR sebelum masuk
- Harus punya SHA256 yang valid
- CI otomatis mengecek setiap package

Tapi tetap **baca `build.sh`** sebelum install jika kamu ingin yakin.

---

### Bagaimana cara upload tool saya?
Baca panduan lengkap di [How to Upload a Package](How-to-Upload-a-Package).

---

### Berapa lama proses review PR package baru?
Biasanya 1-3 hari kerja, tergantung antrian dan kompleksitas package.

---

## Teknis

### Mengapa ada warning `apt does not have stable CLI interface`?
Warning ini normal — `apt` memang sengaja memunculkan ini ketika dipanggil dari dalam script. Tidak mempengaruhi fungsionalitas. Solusinya adalah mengganti `apt` ke `apt-get` di `build-package.sh`.

---

### Apa perbedaan binary native vs universal?
- **Binary native** (`termux-app-store-aarch64` dll): Dikompilasi untuk satu arsitektur, tidak butuh Python
- **Universal** (`termux-app-store-universal`): Python launcher, jalan di semua arsitektur selama Python 3.8+ tersedia

---

### Apakah data saya dikirim ke server?
**Tidak.** TAS adalah offline-first dan zero telemetry:
- Tidak ada analytics
- Tidak ada tracking
- Tidak ada akun
- Tidak ada koneksi ke server TAS manapun

Satu-satunya koneksi internet adalah saat download source package dari URL yang tertulis di `build.sh` (yang bisa kamu baca sendiri).

---

### Di mana package terinstall?
Sesuai prefix Termux standar:
```
/data/data/com.termux/files/usr/
```

---

## Kontribusi

### Bagaimana cara melaporkan bug?
Buka [GitHub Issues](https://github.com/djunekz/termux-app-store/issues) dan gunakan template **Bug Report**.

---

### Bagaimana cara request fitur baru?
Buka [GitHub Issues](https://github.com/djunekz/termux-app-store/issues) dan gunakan template **Feature Request**.

---

### Bisakah saya menjadi maintainer?
Kontribusi aktif (PR, review, issue) adalah jalan terbaik. Hubungi @djunekz jika tertarik.

---

## Lihat Juga

- [Troubleshooting](Troubleshooting) — solusi masalah teknis
- [Contributing Guide](Contributing-Guide) — cara berkontribusi
- [Installation](Installation) — panduan instalasi
