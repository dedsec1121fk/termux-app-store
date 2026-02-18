# 🔐 Security Policy

Kebijakan keamanan Termux App Store.

---

## Komitmen Keamanan

Termux App Store dirancang dengan prinsip **security-first**:

- ✅ Tidak meminta permission tambahan di luar Termux
- ✅ Tidak membuka port jaringan
- ✅ Tidak menjalankan background service
- ✅ Semua aksi build hanya berjalan atas perintah eksplisit pengguna
- ✅ Source code 100% terbuka dan dapat diaudit
- ✅ SHA256 verification wajib untuk setiap package

---

## Verifikasi Package

Setiap package yang masuk ke TAS harus:

1. Memiliki `TERMUX_PKG_SHA256` yang valid
2. Melewati CI check otomatis
3. Direview oleh maintainer
4. Source URL harus dapat diakses publik (tidak boleh private)

---

## Melaporkan Vulnerability

**Jangan buka public issue untuk vulnerability keamanan.**

Laporkan secara privat melalui:
- GitHub Security Advisory: [Report a vulnerability](https://github.com/djunekz/termux-app-store/security/advisories/new)
- Atau kontak langsung maintainer

**Informasi yang perlu disertakan:**
- Deskripsi vulnerability
- Langkah untuk mereproduksi
- Dampak potensial
- Saran perbaikan (jika ada)

---

## Response Time

| Tingkat Keparahan | Target Response |
|---|---|
| Critical | 24 jam |
| High | 72 jam |
| Medium | 7 hari |
| Low | 30 hari |

---

## Scope

Yang termasuk scope vulnerability:
- Remote code execution
- Privilege escalation
- Data exfiltration
- SHA256 bypass

Yang di luar scope:
- Social engineering
- Physical access
- Vulnerability di dependency pihak ketiga (laporkan ke masing-masing project)

---

## Lihat Juga

- [Privacy Policy](Privacy-Policy)
- [SHA256 Verification](SHA256-Verification)
