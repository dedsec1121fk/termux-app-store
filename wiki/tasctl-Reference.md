# ⚙️ tasctl Reference

Panduan lengkap `tasctl` — tool untuk mengelola instalasi Termux App Store itu sendiri.

---

## Apa itu tasctl?

`tasctl` adalah CLI tool untuk mengelola **Termux App Store** sebagai aplikasi — bukan package di dalamnya. Digunakan untuk install, update, dan uninstall TAS sendiri.

> Bedakan: `termux-app-store` untuk mengelola package, `tasctl` untuk mengelola TAS itu sendiri.

---

## Perintah

### `install`
Install Termux App Store.

```bash
./tasctl install
```

---

### `update`
Update Termux App Store ke versi terbaru.

```bash
./tasctl update
```

Proses:
1. Cek versi terbaru di GitHub
2. Download versi baru
3. Replace binary/script lama
4. Verifikasi instalasi

---

### `uninstall`
Uninstall Termux App Store secara bersih.

```bash
./tasctl uninstall
```

Menghapus:
- Binary `termux-app-store` dari `$PREFIX/bin/`
- Alias dari `.bashrc` / `.zshrc`
- Cache TAS (jika ada)

Tidak menghapus:
- Folder `packages/` (agar package data tidak hilang)
- Package yang sudah terinstall via TAS

---

### `status`
Cek status instalasi TAS saat ini.

```bash
./tasctl status
```

Output contoh:
```
Termux App Store Status
─────────────────────────────────
Version    : v0.1.2
Installed  : Yes (/data/.../usr/bin/termux-app-store)
Latest     : v0.1.2 (up to date)
Packages   : 12 packages available
```

---

### `version`
Tampilkan versi tasctl dan TAS.

```bash
./tasctl version
```

---

## Lihat Juga

- [Installation](Installation) — panduan instalasi lengkap
- [Uninstallation](Uninstallation) — cara uninstall
- [Architecture Overview](Architecture-Overview) — struktur file TAS
