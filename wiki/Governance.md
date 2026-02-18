# ⚖️ Governance

Struktur keputusan dan tata kelola proyek Termux App Store.

---

## Struktur

| Peran | Tanggung Jawab |
|---|---|
| **Lead Maintainer** | Keputusan akhir, arah proyek, merge PR |
| **Maintainer** | Review PR, triage issue, moderasi komunitas |
| **Contributor** | Submit PR, laporkan bug, tambah package |
| **User** | Pengguna, feedback, laporan bug |

---

## Lead Maintainer

**Djunekz** — [github.com/djunekz](https://github.com/djunekz)

---

## Proses Keputusan

### Perubahan Kecil (Bug fix, Package update)
- 1 review dari maintainer → Merge

### Perubahan Sedang (Fitur baru, Refactor)
- Diskusi di issue terlebih dahulu
- 1 approval dari Lead Maintainer → Merge

### Perubahan Besar (Breaking change, Arsitektur)
- RFC (Request for Comments) di Discussions
- Periode diskusi minimum 7 hari
- Keputusan oleh Lead Maintainer

---

## Package Review Criteria

Package diterima jika:
- ✅ Semua field `build.sh` lengkap dan valid
- ✅ SHA256 terverifikasi
- ✅ CI check PASS
- ✅ Bukan duplikat dari package yang sudah ada
- ✅ Tidak melanggar hukum atau kebijakan komunitas
- ✅ Source code dapat diaudit publik

---

## Menjadi Maintainer

Kontributor aktif bisa dipertimbangkan menjadi maintainer. Kriteria:
- Kontribusi konsisten selama minimal 3 bulan
- PR yang dikirim berkualitas tinggi
- Aktif mereview PR orang lain
- Menunjukkan pemahaman terhadap filosofi proyek

---

## Lihat Juga

- [Contributing Guide](Contributing-Guide)
- [Code of Conduct](Code-of-Conduct)
