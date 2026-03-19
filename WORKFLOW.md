# Git Workflow untuk Tim Hummatech Kos

## Repository
**GitHub:** https://github.com/drestbellamy/hummatech-kos

## Struktur Branch

```
main                              # Production code (code terbaru yang sudah tested)
  ├── feature/dashboard           # Fitur Dashboard (update terus di sini)
  ├── feature/kost-management     # Fitur Kelola Kost (update terus di sini)
  ├── feature/room-management     # Fitur Kelola Kamar (update terus di sini)
  ├── feature/penghuni-management # Fitur Kelola Penghuni (update terus di sini)
  └── feature/profile             # Fitur Profile (update terus di sini)
```

## Prinsip Dasar

1. **Satu branch = Satu fitur/modul**
2. **Update terus di branch yang sama** (tidak perlu buat branch baru)
3. **Merge ke main** kalau sudah selesai dan tested
4. **Main branch** selalu berisi code terbaru yang bisa dijalankan

---

## 🚀 Workflow untuk Anggota Tim

### Skenario 1: Mulai Mengerjakan Fitur Baru

**Contoh: Anda dapat tugas buat fitur Payment**

```bash
# 1. Update main branch
git checkout main
git pull origin main

# 2. Buat branch baru dari main
git checkout -b feature/payment-system

# 3. Coding...
# Buat payment list screen

# 4. Commit
git add .
git commit -m "feat(payment): add payment list screen"

# 5. Push ke GitHub
git push origin feature/payment-system
```

### Skenario 2: Lanjut Update Fitur yang Sudah Ada

**Contoh: Anda mau update Dashboard (branch sudah ada)**

```bash
# 1. Checkout ke branch dashboard
git checkout feature/dashboard

# 2. Pull perubahan terbaru (jika ada)
git pull origin feature/dashboard

# 3. Coding...
# Tambah card "Total Revenue"

# 4. Commit
git add .
git commit -m "feat(dashboard): add total revenue card"

# 5. Push
git push origin feature/dashboard

# 6. Lanjut coding lagi (tidak perlu branch baru!)
# Tambah filter date range

git add .
git commit -m "feat(dashboard): add date range filter"
git push origin feature/dashboard
```

### Skenario 3: Merge Fitur ke Main (Setelah Selesai)

**Contoh: Dashboard sudah selesai, mau merge ke main**

```bash
# 1. Pastikan branch fitur up-to-date
git checkout feature/dashboard
git pull origin feature/dashboard

# 2. Update dari main (untuk avoid conflict)
git checkout main
git pull origin main
git checkout feature/dashboard
git merge main

# 3. Resolve conflict jika ada
# Edit file yang conflict, lalu:
git add .
git commit -m "resolve merge conflict with main"
git push origin feature/dashboard

# 4. Buat Pull Request di GitHub
# Base: main ← Compare: feature/dashboard

# 5. Setelah approved dan merged, update local main
git checkout main
git pull origin main

# 6. JANGAN hapus branch feature!
# Branch feature tetap ada untuk update selanjutnya
```

---

## 📋 Aturan Penting

### ✅ LAKUKAN:
- Commit sesering mungkin dengan pesan yang jelas
- Push ke branch fitur Anda setiap hari
- Test fitur sebelum merge ke main
- Buat Pull Request untuk review
- Update branch fitur dari main secara berkala

### ❌ JANGAN:
- Push langsung ke main (selalu via Pull Request)
- Commit dengan pesan tidak jelas ("update", "fix")
- Hapus branch fitur setelah merge (tetap pakai untuk update)
- Merge tanpa testing

---

## 🎯 Contoh Lengkap: Update Fitur Kost

```bash
# === WEEK 1: Fitur sudah ada, mau tambah filter ===
git checkout feature/kost-management
git pull origin feature/kost-management

# Coding: Tambah filter by location
git add .
git commit -m "feat(kost): add filter by location"
git push origin feature/kost-management

# === WEEK 2: Tambah sorting ===
# Masih di branch yang sama
git pull origin feature/kost-management

# Coding: Tambah sorting by price
git add .
git commit -m "feat(kost): add sorting by price"
git push origin feature/kost-management

# === WEEK 3: Fix bug ===
# Masih di branch yang sama
git pull origin feature/kost-management

# Coding: Fix bug di filter
git add .
git commit -m "fix(kost): resolve filter bug when location is empty"
git push origin feature/kost-management

# === Merge ke main (via Pull Request) ===
# Buat PR di GitHub: main ← feature/kost-management
# Setelah approved dan merged:
git checkout main
git pull origin main

# Branch feature/kost-management tetap ada untuk update selanjutnya!
```

---

## 🔄 Update dari Main (Penting!)

**Lakukan ini seminggu sekali atau sebelum merge:**

```bash
# Pastikan branch fitur Anda sync dengan main
git checkout feature/your-branch
git pull origin feature/your-branch

git checkout main
git pull origin main

git checkout feature/your-branch
git merge main

# Jika ada conflict, resolve lalu:
git add .
git commit -m "merge main into feature/your-branch"
git push origin feature/your-branch
```

---

## 👥 Pembagian Branch per Anggota Tim

### Anggota 1: Dashboard & Analytics
- Branch: `feature/dashboard`
- Semua update dashboard di branch ini

### Anggota 2: Kost & Room Management
- Branch: `feature/kost-management` dan `feature/room-management`
- Semua update kost/room di branch ini

### Anggota 3: Penghuni Management
- Branch: `feature/penghuni-management`
- Semua update penghuni di branch ini

### Anggota 4: Profile & Settings
- Branch: `feature/profile`
- Semua update profile di branch ini

---

## 🎨 Format Commit Message

```bash
# Format:
git commit -m "type(scope): description"

# Contoh:
git commit -m "feat(dashboard): add new statistics card"
git commit -m "fix(kost): resolve navigation bug"
git commit -m "refactor(room): improve performance"
git commit -m "style(dashboard): fix card alignment"
git commit -m "docs: update README"
```

**Type:**
- `feat` - Fitur baru
- `fix` - Bug fix
- `refactor` - Refactoring
- `style` - Styling/formatting
- `docs` - Dokumentasi
- `test` - Testing
- `chore` - Maintenance

---

## 🚨 Troubleshooting

### Conflict saat merge dari main
```bash
git checkout feature/your-branch
git merge main

# Jika conflict:
# 1. Buka file yang conflict
# 2. Cari marker <<<<<<< ======= >>>>>>>
# 3. Edit manual, pilih code yang benar
# 4. Hapus marker
# 5. Save

git add .
git commit -m "resolve merge conflict"
git push origin feature/your-branch
```

### Salah commit di branch yang salah
```bash
# Undo commit terakhir (file tetap ada)
git reset --soft HEAD~1

# Pindah ke branch yang benar
git checkout branch-yang-benar

# Commit lagi
git add .
git commit -m "your message"
git push origin branch-yang-benar
```

### Ingin lihat perubahan sebelum commit
```bash
git status          # Lihat file yang berubah
git diff            # Lihat detail perubahan
git diff --staged   # Lihat yang sudah di-add
```

---

## 📊 Ringkasan Workflow

```
1. Checkout ke branch fitur Anda
   ↓
2. Pull perubahan terbaru
   ↓
3. Coding + Test
   ↓
4. Commit + Push (sesering mungkin)
   ↓
5. Ulangi step 3-4 sampai fitur selesai
   ↓
6. Merge main ke branch fitur (untuk sync)
   ↓
7. Buat Pull Request ke main
   ↓
8. Review oleh tim
   ↓
9. Merge ke main
   ↓
10. Update local main
   ↓
11. Lanjut update di branch fitur yang sama
```

---

## 🎯 Keuntungan Workflow Ini

✅ **Simpel** - Tidak perlu maintain branch develop  
✅ **Jelas** - Satu branch = Satu modul/fitur  
✅ **Fleksibel** - Bisa update kapan saja di branch masing-masing  
✅ **Aman** - Main branch selalu protected via Pull Request  
✅ **Efisien** - Tidak perlu buat branch baru untuk setiap update kecil  

---

**Last Updated:** 2026-03-19
