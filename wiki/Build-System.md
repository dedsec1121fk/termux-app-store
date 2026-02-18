# 🔨 Build System

Penjelasan cara kerja `build-package.sh` — mesin build utama Termux App Store.

---

## Peran build-package.sh

`build-package.sh` adalah script yang dipanggil saat kamu menjalankan `termux-app-store install`. Script ini yang melakukan pekerjaan berat: download, verifikasi, dan install.

---

## Alur Eksekusi

```bash
build-package.sh packages/baxter/build.sh
```

```
1. Load build.sh → baca semua TERMUX_PKG_* variables
        ↓
2. Tampilkan info build (nama, versi, arch, prefix)
        ↓
3. Resolve dependencies
   → Untuk setiap item di TERMUX_PKG_DEPENDS:
     → apt-get install -y <dep>
        ↓
4. Download source
   → curl -L TERMUX_PKG_SRCURL → /tmp/source.tar.gz
        ↓
5. Verifikasi SHA256
   → sha256sum /tmp/source.tar.gz == TERMUX_PKG_SHA256?
   → Tidak cocok → abort dengan error
        ↓
6. Extract source
   → tar -xf /tmp/source.tar.gz
        ↓
7. Build & Install
   → Jalankan termux_step_make_install() jika ada
   → Atau default install behavior
        ↓
8. Cleanup
   → Hapus file temporary
        ↓
9. Verifikasi post-install
   → Cek binary/tool berhasil terinstall
        ↓
10. Done ✓
```

---

## Output Build

```
[*] Installing baxter v1.2.4...
======================================================================
                      Termux App Store Builder
                github.com/djunekz/termux-app-store
======================================================================
  :: System & Architecture
----------------------------------------------------------------------
    Package :   baxter
    Version :   1.2.4
    Arch    :   aarch64
    Prefix  :   /data/data/com.termux/files/usr
  :: Dependencies
----------------------------------------------------------------------
  [  OK  ]  nodejs — already installed
  [  OK  ]  python — already installed
  :: Download
----------------------------------------------------------------------
  [  OK  ]  Downloaded 2.4MB
  [  OK  ]  SHA256 verified
  :: Build
----------------------------------------------------------------------
  [  OK  ]  Build complete
  [  OK  ]  baxter v1.2.4 installed!
======================================================================
```

---

## Mengapa apt-get bukan apt?

`build-package.sh` menggunakan `apt-get` (bukan `apt`) karena:
- `apt` menampilkan warning saat dipakai dalam script
- `apt-get` dirancang untuk penggunaan non-interaktif dan scripting
- Output lebih bersih, tidak ada warning tambahan

---

## Lihat Juga

- [Architecture Overview](Architecture-Overview)
- [Package Structure](Package-Structure)
- [Build Script Reference](Build-Script-Reference)
