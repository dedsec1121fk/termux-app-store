# 🗑️ Uninstallation

Cara menghapus Termux App Store dari perangkat kamu.

---

## Cara 1 — Via tasctl (Disarankan)

```bash
./tasctl uninstall
```

---

## Cara 2 — Via Script

```bash
bash uninstall.sh
```

---

## Cara 3 — Manual

```bash
# Hapus binary
rm -f $PREFIX/bin/termux-app-store

# Hapus alias (jika ada)
sed -i '/termux-app-store/d' ~/.bashrc
sed -i '/termux-app-store/d' ~/.zshrc

# Hapus folder (opsional — ini akan menghapus semua package data)
rm -rf ~/termux-app-store
```

---

## Yang Dihapus vs Tidak Dihapus

| | Dihapus? |
|---|---|
| Binary `termux-app-store` | ✅ Ya |
| Alias di shell config | ✅ Ya |
| Folder `packages/` | ❌ Tidak (aman) |
| Package yang terinstall via TAS | ❌ Tidak |
| Tool yang terinstall | ❌ Tidak |

Package dan tool yang sudah terinstall **tidak ikut terhapus** — mereka adalah bagian dari `$PREFIX` Termux normal.

---

## Install Ulang Setelah Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/djunekz/termux-app-store/main/install.sh | bash
```

---

## Lihat Juga

- [Installation](Installation)
- [tasctl Reference](tasctl-Reference)
