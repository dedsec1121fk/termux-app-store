# 🧬 Binary Release

Penjelasan tentang proses build dan distribusi binary Termux App Store.

---

## Tersedia Binary Apa Saja?

Di setiap [release](https://github.com/djunekz/termux-app-store/releases), tersedia:

| File | Deskripsi | Cocok untuk |
|---|---|---|
| `termux-app-store-aarch64` | Binary native ARM 64-bit | HP Android modern (kebanyakan) |
| `termux-app-store-arm` | Binary native ARM 32-bit | HP Android lama |
| `termux-app-store-x86_64` | Binary native x86 64-bit | Emulator / ChromeOS |
| `termux-app-store-i686` | Binary native x86 32-bit | Emulator lama |
| `termux-app-store-universal` | Python launcher | Semua arsitektur (butuh Python 3.8+) |
| `SHA256SUMS` | Checksum semua file | Verifikasi integritas |

---

## Cara Cek Arsitektur

```bash
uname -m
# Output: aarch64, armv7l, x86_64, atau i686
```

---

## Download Binary

```bash
# Deteksi arsitektur otomatis & download
ARCH=$(uname -m)
curl -L "https://github.com/djunekz/termux-app-store/releases/latest/download/termux-app-store-${ARCH}" \
  -o termux-app-store
chmod +x termux-app-store
mv termux-app-store $PREFIX/bin/
```

---

## Binary vs Universal

**Gunakan binary native** jika:
- Tidak mau install Python
- Ingin startup lebih cepat
- Tahu arsitektur device kamu

**Gunakan universal** jika:
- Tidak yakin arsitektur
- Python sudah terinstall
- Ingin satu file untuk semua device

---

## Proses Build Binary

Binary dibangun menggunakan `build-bin.sh`:

```bash
# Di device/environment dengan arsitektur yang diinginkan
./build-bin.sh
```

Hasilnya di folder `release/`:
```
release/
├── termux-app-store-aarch64
├── termux-app-store-universal
└── SHA256SUMS
```

Untuk mendapatkan binary semua arsitektur, `build-bin.sh` perlu dijalankan di masing-masing arsitektur.

---

## Verifikasi Binary

Selalu verifikasi sebelum menjalankan binary:

```bash
curl -L https://github.com/djunekz/termux-app-store/releases/latest/download/SHA256SUMS -o SHA256SUMS
sha256sum -c SHA256SUMS
```

---

## Lihat Juga

- [SHA256 Verification](SHA256-Verification)
- [Installation](Installation)
