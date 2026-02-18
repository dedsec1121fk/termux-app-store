# 🏗️ Architecture Overview

Penjelasan teknis cara kerja internal Termux App Store.

---

## Gambaran Umum

```
┌────────────────────────────────────────────────────────┐
│                  Termux App Store                      │
├────────────────────────┬───────────────────────────────┤
│     TUI Interface      │       CLI Interface           │
│  (Textual / Python)    │   (argparse / shell)          │
├────────────────────────┴───────────────────────────────┤
│                    Core Engine                         │
│  • Package Scanner    • Metadata Parser                │
│  • Version Checker    • Dependency Resolver            │
│  • Status Badge       • Self-Healing Path Resolver     │
├────────────────────────────────────────────────────────┤
│                  Build System                          │
│              build-package.sh                          │
│  • Download Source    • SHA256 Verify                  │
│  • apt-get deps       • Build & Install                │
│  • Progress Log       • Error Handling                 │
├────────────────────────────────────────────────────────┤
│               Package Repository                       │
│              packages/<name>/build.sh                  │
└────────────────────────────────────────────────────────┘
```

---

## Alur Kerja Lengkap

### 1. Startup

```
termux-app-store (binary / python)
        │
        ▼
Self-Healing Path Resolver
  Cari folder termux-app-store/packages/
  dari berbagai kemungkinan lokasi
        │
        ▼
Package Scanner
  Scan semua subfolder di packages/
  Baca setiap build.sh
        │
        ▼
Metadata Parser
  Extract: NAME, VERSION, DESCRIPTION,
           DEPENDS, HOMEPAGE, dll
        │
        ▼
Version Checker
  Bandingkan TERMUX_PKG_VERSION
  dengan versi yang terinstall di sistem
        │
        ▼
Status Badge Generator
  Assign: NEW / UPDATE / INSTALLED / UNSUPPORTED
        │
        ▼
TUI / CLI Renderer
  Tampilkan hasil ke pengguna
```

---

### 2. Alur Install Package

```
User: termux-app-store install baxter
        │
        ▼
Read packages/baxter/build.sh
        │
        ▼
Dependency Check
  Untuk setiap item di TERMUX_PKG_DEPENDS:
    - Cek apakah sudah terinstall
    - Jika belum → apt-get install
        │
        ▼
Download Source
  curl -L TERMUX_PKG_SRCURL → source.tar.gz
        │
        ▼
SHA256 Verification
  sha256sum source.tar.gz == TERMUX_PKG_SHA256?
  Tidak cocok → abort dengan error
        │
        ▼
build-package.sh
  Extract → Configure → Make → Install
        │
        ▼
Post-install Verification
  Cek apakah binary/tool berhasil terinstall
        │
        ▼
Done ✓
```

---

## Struktur File & Folder

```
termux-app-store/
│
├── termux-app-store.py      ← Entry point utama (Python/Textual)
│
├── packages/                ← Repository semua package
│   ├── baxter/
│   │   └── build.sh
│   ├── zora/
│   │   └── build.sh
│   └── .../
│
├── build-package.sh         ← Build engine utama
├── install.sh               ← Installer TAS sendiri
├── uninstall.sh             ← Uninstaller TAS
├── tasctl                   ← CLI manager untuk TAS itu sendiri
├── termux-build             ← Validation tool (read-only)
│
├── template/
│   └── build.sh             ← Template untuk package baru
│
├── tools/                   ← Internal helper scripts
│
├── ci/                      ← Script untuk CI pipeline
│
├── .github/
│   ├── workflows/           ← GitHub Actions
│   ├── ISSUE_TEMPLATE/      ← Template issue
│   └── PULL_REQUEST_TEMPLATE.md
│
└── .circleci/               ← CircleCI config
    └── config.yml
```

---

## Self-Healing Path Resolver

Salah satu fitur penting TAS adalah kemampuan menemukan folder `packages/` meski dipindahkan.

```python
# Pseudocode Self-Healing Path Resolver
SEARCH_PATHS = [
    script_dir / "packages",
    script_dir / ".." / "packages",
    home / "termux-app-store" / "packages",
    prefix / "share" / "termux-app-store" / "packages",
    "/data/data/com.termux/files/home/termux-app-store/packages",
]

for path in SEARCH_PATHS:
    if path.exists():
        return path

raise PackagesNotFoundError("Folder packages/ tidak ditemukan")
```

---

## Metadata Parser

Membaca variabel dari `build.sh` tanpa mengeksekusi script:

```python
# Pseudocode Metadata Parser
def parse_build_sh(path):
    metadata = {}
    with open(path) as f:
        for line in f:
            # Match: TERMUX_PKG_VERSION="1.2.4"
            match = re.match(r'TERMUX_PKG_(\w+)="?([^"]*)"?', line)
            if match:
                key = match.group(1)
                value = match.group(2)
                # Resolve variables: ${TERMUX_PKG_VERSION}
                value = resolve_vars(value, metadata)
                metadata[key] = value
    return metadata
```

> **Penting:** Metadata dibaca secara **static** (tidak dieksekusi), sehingga aman dan tidak ada side effect.

---

## Status Badge Logic

```python
def get_status(pkg_name, pkg_version, depends):
    # Cek UNSUPPORTED dulu
    for dep in depends:
        if not is_available_in_termux(dep):
            return "UNSUPPORTED"

    installed = get_installed_version(pkg_name)

    if installed is None:
        # Cek apakah package baru (< 7 hari)
        if days_since_added(pkg_name) < 7:
            return "NEW"
        return "AVAILABLE"

    if version_compare(pkg_version, installed) > 0:
        return "UPDATE"

    return "INSTALLED"
```

---

## CI/CD Pipeline

```
Push / PR ke master
        │
        ├── GitHub Actions (build.yml)
        │       │
        │       ├── Lint semua changed packages
        │       ├── Validate build.sh format
        │       └── Report hasil ke PR
        │
        └── CircleCI (.circleci/config.yml)
                │
                ├── Run ./termux-build check-pr
                ├── Integration test
                └── Code coverage (Codecov)
```

---

## Teknologi yang Digunakan

| Komponen | Teknologi |
|---|---|
| TUI Framework | [Textual](https://github.com/Textualize/textual) (Python) |
| CLI | Python argparse |
| Build Engine | Bash shell script |
| Binary Packaging | PyInstaller / Nuitka |
| CI/CD | GitHub Actions + CircleCI |
| Code Coverage | Codecov |
| Package Validation | termux-build (Bash) |

---

## Lihat Juga

- [Build System](Build-System) — detail cara kerja `build-package.sh`
- [Binary Release](Binary-Release) — proses build binary
- [tasctl Reference](tasctl-Reference) — manajemen instalasi TAS
