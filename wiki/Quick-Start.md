# ⚡ Quick Start

Panduan cepat untuk langsung produktif dengan Termux App Store.

---

## Langkah 1 — Install

```bash
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash
```

---

## Langkah 2 — Buka TUI

```bash
termux-app-store
```

Kamu akan melihat antarmuka TUI seperti ini:

```
╔══════════════════════════════════════════════════╗
║          Termux App Store  v0.1.2               ║
╠══════════════════════════════════════════════════╣
║  🔍 Search: [                              ]     ║
╠══════════════════════════════════════════════════╣
║  📦 baxter          v1.2.4    🟢 NEW            ║
║  📦 zora            v1.0.0    🟡 UPDATE         ║
║  📦 mytool          v2.1.0    🟢 INSTALLED      ║
║  📦 legacytool      v0.9.0    🔴 UNSUPPORTED    ║
╠══════════════════════════════════════════════════╣
║  [I]nstall  [U]pdate  [S]earch  [Q]uit          ║
╚══════════════════════════════════════════════════╝
```

---

## Langkah 3 — Cari Package

Di dalam TUI, ketik nama package langsung untuk search real-time.

Atau via CLI:

```bash
termux-app-store list
```

---

## Langkah 4 — Install Package

```bash
# Via CLI
termux-app-store install baxter

# Output yang akan muncul:
# [*] Installing baxter v1.2.4...
# [✓] Dependencies resolved
# [✓] Build complete
# [✓] baxter v1.2.4 installed!
```

---

## Langkah 5 — Update Package

```bash
# Update semua package
termux-app-store upgrade

# Update satu package
termux-app-store upgrade baxter
```

---

## Cheat Sheet Perintah Dasar

| Perintah | Fungsi |
|---|---|
| `termux-app-store` | Buka TUI |
| `termux-app-store list` | Lihat semua package |
| `termux-app-store search <kata>` | Cari package |
| `termux-app-store install <pkg>` | Install package |
| `termux-app-store show <pkg>` | Detail package |
| `termux-app-store upgrade` | Upgrade semua |
| `termux-app-store version` | Cek versi TAS |

---

## Langkah Selanjutnya

- 🖥️ [TUI Guide](TUI-Guide) — fitur lengkap antarmuka TUI
- 📟 [CLI Reference](CLI-Reference) — semua perintah CLI
- 📦 [How to Upload a Package](How-to-Upload-a-Package) — bagikan tool kamu
