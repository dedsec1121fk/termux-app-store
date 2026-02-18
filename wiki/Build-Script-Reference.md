# 📋 Build Script Reference

Referensi lengkap semua variabel yang bisa digunakan di `build.sh`.

---

## Variabel Wajib

| Variabel | Tipe | Deskripsi |
|---|---|---|
| `TERMUX_PKG_HOMEPAGE` | URL | Homepage atau repository tool |
| `TERMUX_PKG_DESCRIPTION` | String | Deskripsi singkat (maks 80 karakter) |
| `TERMUX_PKG_LICENSE` | String | Lisensi SPDX: MIT, GPL-3.0, Apache-2.0, dll |
| `TERMUX_PKG_MAINTAINER` | String | Format: `@github-username` |
| `TERMUX_PKG_VERSION` | SemVer | Versi: `1.0.0`, `2.1.4`, dll |
| `TERMUX_PKG_SRCURL` | URL | URL download source code |
| `TERMUX_PKG_SHA256` | Hex 64 | SHA256 hash dari file di SRCURL |

---

## Variabel Opsional

| Variabel | Tipe | Deskripsi |
|---|---|---|
| `TERMUX_PKG_DEPENDS` | String | Dependency runtime (comma-separated) |
| `TERMUX_PKG_BUILD_DEPENDS` | String | Dependency hanya saat build |
| `TERMUX_PKG_RECOMMENDS` | String | Dependency opsional yang direkomendasikan |
| `TERMUX_PKG_CONFLICTS` | String | Package yang konflik |
| `TERMUX_PKG_REPLACES` | String | Package yang digantikan |
| `TERMUX_PKG_SRCDIR` | String | Nama folder setelah extract |
| `TERMUX_PKG_MIN_TERMUX_VERSION` | String | Versi minimum Termux |

---

## Variable Substitution

Kamu bisa pakai variabel lain di dalam nilai:

```bash
TERMUX_PKG_VERSION="1.2.4"
TERMUX_PKG_SRCURL="https://github.com/user/tool/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
# Hasilnya: .../v1.2.4.tar.gz
```

---

## Custom Build Steps (Opsional)

Jika build default tidak cukup, kamu bisa override dengan fungsi bash:

```bash
# Dijalankan sebelum build
termux_step_pre_configure() {
    # custom pre-configure
}

# Dijalankan untuk install
termux_step_make_install() {
    pip install --prefix="$TERMUX_PREFIX" .
    # atau
    npm install -g --prefix="$TERMUX_PREFIX" .
    # atau
    cp mybinary "$TERMUX_PREFIX/bin/"
}

# Dijalankan setelah install
termux_step_post_make_install() {
    # custom post-install
}
```

---

## Variabel Lingkungan yang Tersedia di build.sh

| Variabel | Nilai |
|---|---|
| `$TERMUX_PREFIX` | `/data/data/com.termux/files/usr` |
| `$TERMUX_HOME` | `/data/data/com.termux/files/home` |
| `$TERMUX_ARCH` | `aarch64`, `arm`, `x86_64`, atau `i686` |
| `$TERMUX_PKG_BUILDDIR` | Folder build sementara |
| `$TERMUX_PKG_SRCDIR` | Folder source setelah extract |

---

## Lisensi yang Diakui

```
MIT, GPL-2.0, GPL-3.0, LGPL-2.1, LGPL-3.0,
Apache-2.0, BSD-2-Clause, BSD-3-Clause,
ISC, MPL-2.0, AGPL-3.0, Unlicense, CC0-1.0
```

Untuk lisensi custom, gunakan: `custom` atau `custom;<nama-lisensi>`

---

## Lihat Juga

- [Package Structure](Package-Structure) — struktur folder package
- [How to Upload a Package](How-to-Upload-a-Package) — alur upload
- [termux-build Tool](termux-build-Tool) — validasi build.sh
