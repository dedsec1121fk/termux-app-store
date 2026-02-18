# 📦 Package Structure

Panduan lengkap struktur package yang valid di Termux App Store.

---

## Struktur Wajib

Setiap package **wajib** memiliki minimal satu file:

```
packages/
└── nama-package/
    └── build.sh          ← WAJIB
```

---

## Struktur Lengkap (Disarankan)

```
packages/
└── nama-package/
    ├── build.sh           ← WAJIB — metadata & build config
    ├── build.patch        ← Opsional — patch source code
    ├── README.md          ← Opsional — deskripsi package
    └── subpackages/       ← Opsional — subpackage tambahan
        └── nama-sub.sh
```

---

## File `build.sh` — Variabel Wajib

```bash
TERMUX_PKG_HOMEPAGE=""        # URL homepage / repository tool
TERMUX_PKG_DESCRIPTION=""     # Deskripsi singkat (maks 80 karakter)
TERMUX_PKG_LICENSE=""         # Lisensi: MIT, GPL-3.0, Apache-2.0, dll
TERMUX_PKG_MAINTAINER=""      # Format: @github-username
TERMUX_PKG_VERSION=""         # Versi: format SemVer (1.0.0)
TERMUX_PKG_SRCURL=""          # URL download source code
TERMUX_PKG_SHA256=""          # SHA256 hash dari file di SRCURL
```

---

## File `build.sh` — Variabel Opsional

```bash
# Dependency yang dibutuhkan (package Termux)
TERMUX_PKG_DEPENDS=""         # Contoh: "nodejs, python, curl"

# Dependency hanya untuk build (tidak ikut di release)
TERMUX_PKG_BUILD_DEPENDS=""   # Contoh: "cmake, make"

# Dependency opsional
TERMUX_PKG_RECOMMENDS=""

# Konflik dengan package lain
TERMUX_PKG_CONFLICTS=""

# Menggantikan package lain
TERMUX_PKG_REPLACES=""

# Nama file setelah didownload (jika beda dari URL)
TERMUX_PKG_SRCDIR=""

# Skip verifikasi SHA256 (TIDAK DISARANKAN)
TERMUX_PKG_SHA256="SKIP"

# Versi minimum Termux yang dibutuhkan
TERMUX_PKG_MIN_TERMUX_VERSION=""
```

---

## Contoh `build.sh` Lengkap

```bash
TERMUX_PKG_HOMEPAGE="https://github.com/djunekz/baxter"
TERMUX_PKG_DESCRIPTION="Automation tool for Termux power users"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@djunekz"
TERMUX_PKG_VERSION="1.2.4"
TERMUX_PKG_SRCURL="https://github.com/djunekz/baxter/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2"
TERMUX_PKG_DEPENDS="python, curl"
```

---

## Contoh `build.sh` untuk Tool Python

```bash
TERMUX_PKG_HOMEPAGE="https://github.com/author/mytool"
TERMUX_PKG_DESCRIPTION="My awesome Python tool for Termux"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@author"
TERMUX_PKG_VERSION="2.0.0"
TERMUX_PKG_SRCURL="https://github.com/author/mytool/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="abc123..."
TERMUX_PKG_DEPENDS="python, python-pip"

termux_step_make_install() {
    pip install --prefix="$TERMUX_PREFIX" .
}
```

---

## Contoh `build.sh` untuk Tool Node.js

```bash
TERMUX_PKG_HOMEPAGE="https://github.com/author/nodetool"
TERMUX_PKG_DESCRIPTION="Node.js based automation tool"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@author"
TERMUX_PKG_VERSION="1.0.0"
TERMUX_PKG_SRCURL="https://github.com/author/nodetool/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="def456..."
TERMUX_PKG_DEPENDS="nodejs, npm"

termux_step_make_install() {
    npm install -g --prefix="$TERMUX_PREFIX" .
}
```

---

## Aturan Penamaan Package

| Aturan | Contoh Benar | Contoh Salah |
|---|---|---|
| Huruf kecil semua | `my-tool` | `MyTool` |
| Gunakan tanda hubung `-` | `my-tool` | `my_tool` |
| Tidak boleh spasi | `mytool` | `my tool` |
| Tidak boleh diawali angka | `tool1` | `1tool` |
| Nama unik di folder packages | — | — |

---

## Generate Template Otomatis

Daripada tulis manual, gunakan perintah ini:

```bash
./termux-build template
```

Atau untuk template dengan nama package langsung:

```bash
./termux-build template my-package
# Akan membuat: packages/my-package/build.sh
```

---

## Validasi Package

Sebelum submit PR, selalu validasi dulu:

```bash
./termux-build lint packages/nama-package
```

Output yang bagus:
```
[✓] TERMUX_PKG_HOMEPAGE   — OK
[✓] TERMUX_PKG_DESCRIPTION — OK (45 chars)
[✓] TERMUX_PKG_LICENSE    — OK (MIT)
[✓] TERMUX_PKG_MAINTAINER — OK (@djunekz)
[✓] TERMUX_PKG_VERSION    — OK (1.2.4 — SemVer valid)
[✓] TERMUX_PKG_SRCURL     — OK (reachable)
[✓] TERMUX_PKG_SHA256     — OK (verified)

✅ Package valid! Siap untuk PR.
```

---

## Lihat Juga

- [Build Script Reference](Build-Script-Reference) — semua variabel dijelaskan detail
- [termux-build Tool](termux-build-Tool) — cara validasi package
- [How to Upload a Package](How-to-Upload-a-Package) — submit package ke store
