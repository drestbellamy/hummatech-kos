# Hummatech Kos - Aplikasi Manajemen Kost

Aplikasi mobile untuk manajemen kost (boarding house) yang digunakan oleh pemilik kos/admin untuk mengelola properti, kamar, dan penghuni.

## 🏠 Fitur Utama

### ✅ Dashboard Admin
- Statistik real-time (Total Kost, Total Kamar, Kamar Kosong, Total Penghuni)
- Grafik tingkat hunian kamar (donut chart)
- Informasi tagihan belum bayar dan penghuni menunggu verifikasi
- Quick actions untuk akses cepat ke fitur utama

### ✅ Manajemen Kost
- Daftar semua boarding house
- Tambah boarding house baru
- Edit informasi boarding house
- Hapus boarding house
- Lihat detail per boarding house

### ✅ Manajemen Kamar
- Daftar kamar per boarding house
- Filter kamar: All Rooms, Empty, Occupied
- Informasi detail kamar (nama, harga, status, penghuni)
- Edit dan hapus kamar

## 📱 Menu Navigasi

1. **Beranda** - Dashboard dengan statistik dan quick actions
2. **Kost** - Kelola boarding houses dan kamar
3. **Penghuni** - Kelola data penghuni (coming soon)
4. **Profil** - Pengaturan akun admin (coming soon)

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** StatefulWidget
- **Platform:** Android & iOS

## 📦 Instalasi

### Prerequisites
- Flutter SDK (3.0.0 atau lebih baru)
- Dart SDK
- Android Studio / VS Code
- Git

### Setup Project

1. Clone repository:
```bash
git clone https://github.com/drestbellamy/hummatech-kos.git
cd hummatech-kos
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run aplikasi:
```bash
flutter run
```

## 📁 Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Data models
│   ├── kost_model.dart
│   └── room_model.dart
├── screens/                  # Halaman aplikasi
│   ├── main_screen.dart
│   ├── dashboard_screen.dart
│   ├── kost_screen.dart
│   ├── kost_detail_screen.dart
│   ├── penghuni_screen.dart
│   └── profile_screen.dart
└── widgets/                  # Reusable widgets
    ├── dashboard_header.dart
    ├── stats_card.dart
    ├── room_occupancy_chart.dart
    ├── quick_action_card.dart
    ├── kost_card.dart
    ├── room_card.dart
    ├── add_kost_dialog.dart
    └── edit_kost_dialog.dart
```

## 🎨 Design System

### Color Palette
- **Primary:** `#6B9080` (Hijau)
- **Secondary:** `#E8A87C` (Orange)
- **Error:** `#E53E3E` (Merah)
- **Background:** `#F5F5F5` (Abu-abu terang)
- **Text Primary:** `#2D3748` (Hitam keabu-abuan)
- **Text Secondary:** `#718096` (Abu-abu)

### Typography
- **Heading:** Bold, 20-24px
- **Body:** Regular, 14-16px
- **Caption:** Regular, 12px

