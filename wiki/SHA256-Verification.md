# 🔑 SHA256 Verification

Cara memverifikasi integritas binary dan package di Termux App Store.

---

## Mengapa SHA256 Penting?

SHA256 memastikan bahwa file yang kamu download:
- Tidak rusak saat transfer
- Tidak dimodifikasi oleh pihak ketiga
- Sama persis dengan yang dirilis maintainer

---

## Verifikasi Binary TAS

```bash
# Download file SHA256SUMS dari release
curl -L https://github.com/djunekz/termux-app-store/releases/latest/download/SHA256SUMS \
  -o SHA256SUMS

# Lihat isi
cat SHA256SUMS
# Output:
# a1b2c3...  termux-app-store-aarch64
# d4e5f6...  termux-app-store-x86_64
# abc123...  termux-app-store-universal

# Verifikasi file yang kamu download
sha256sum -c SHA256SUMS
# Output yang benar:
# termux-app-store-aarch64: OK
```

---

## Verifikasi Package Source

Saat install package, TAS otomatis verifikasi SHA256. Tapi kamu juga bisa cek manual:

```bash
# Lihat SHA256 yang diharapkan di build.sh
cat packages/baxter/build.sh | grep SHA256
# TERMUX_PKG_SHA256="a1b2c3d4..."

# Download source
curl -L "https://github.com/..." -o source.tar.gz

# Bandingkan
sha256sum source.tar.gz
# a1b2c3d4...  source.tar.gz
```

---

## Generate SHA256

Untuk maintainer package yang ingin mendapatkan SHA256 dari source:

```bash
# Download source dulu
curl -L "https://github.com/kamu/tool/archive/refs/tags/v1.0.0.tar.gz" -o source.tar.gz

# Generate SHA256
sha256sum source.tar.gz
# Output: abc123def456...  source.tar.gz
# Copy nilai pertama ke TERMUX_PKG_SHA256
```

---

## Jika SHA256 Tidak Cocok

```
[✗] SHA256 mismatch!
    Expected: a1b2c3d4...
    Got:      xyz789...
    Aborting installation.
```

Jika ini terjadi:
1. Coba download ulang (mungkin koneksi putus)
2. Jika masih gagal, **laporkan sebagai issue** — mungkin maintainer perlu update SHA256

---

## Lihat Juga

- [Security Policy](Security-Policy)
- [Binary Release](Binary-Release)
