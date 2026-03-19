# Backend Integration Guide

Dokumentasi untuk integrasi frontend (Flutter) dengan backend API.

## 🔐 Authentication Flow

### 1. Login Endpoint

**Endpoint:** `POST /api/auth/login`

**Request Body:**
```json
{
  "username": "string",
  "password": "string"
}
```

**Response Success (200):**
```json
{
  "success": true,
  "data": {
    "token": "jwt_token_here",
    "user": {
      "id": "user_id",
      "username": "admin",
      "role": "admin", // "admin" atau "user"
      "name": "Nama Lengkap",
      "email": "email@example.com"
    }
  },
  "message": "Login berhasil"
}
```

**Response Error (401):**
```json
{
  "success": false,
  "message": "Username atau password salah"
}
```

### 2. Logout Endpoint

**Endpoint:** `POST /api/auth/logout`

**Headers:**
```
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "message": "Logout berhasil"
}
```

---

## 🏠 Kost Management Endpoints

### Get All Kost (Admin)

**Endpoint:** `GET /api/kost`

**Headers:**
```
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "kost_id",
      "name": "Green Valley Kost",
      "address": "Jl. Sudirman No. 123, Jakarta",
      "total_rooms": 12,
      "occupied_rooms": 8,
      "empty_rooms": 4
    }
  ]
}
```

### Create Kost (Admin)

**Endpoint:** `POST /api/kost`

**Headers:**
```
Authorization: Bearer {token}
```

**Request Body:**
```json
{
  "name": "Green Valley Kost",
  "address": "Jl. Sudirman No. 123, Jakarta",
  "total_rooms": 12
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "kost_id",
    "name": "Green Valley Kost",
    "address": "Jl. Sudirman No. 123, Jakarta",
    "total_rooms": 12
  },
  "message": "Kost berhasil ditambahkan"
}
```

### Update Kost (Admin)

**Endpoint:** `PUT /api/kost/{id}`

**Headers:**
```
Authorization: Bearer {token}
```

**Request Body:**
```json
{
  "name": "Green Valley Kost Updated",
  "address": "Jl. Sudirman No. 123, Jakarta",
  "total_rooms": 15
}
```

### Delete Kost (Admin)

**Endpoint:** `DELETE /api/kost/{id}`

**Headers:**
```
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "message": "Kost berhasil dihapus"
}
```

---

## 🚪 Room Management Endpoints

### Get Rooms by Kost

**Endpoint:** `GET /api/kost/{kost_id}/rooms`

**Query Parameters:**
- `status` (optional): "all", "empty", "occupied"

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "room_id",
      "name": "Room A-101",
      "price": 1500000,
      "is_occupied": true,
      "tenant": {
        "id": "tenant_id",
        "name": "John Doe"
      }
    }
  ]
}
```

### Create Room (Admin)

**Endpoint:** `POST /api/kost/{kost_id}/rooms`

**Request Body:**
```json
{
  "name": "Room A-101",
  "price": 1500000
}
```

### Update Room (Admin)

**Endpoint:** `PUT /api/rooms/{id}`

**Request Body:**
```json
{
  "name": "Room A-101",
  "price": 1600000
}
```

### Delete Room (Admin)

**Endpoint:** `DELETE /api/rooms/{id}`

---

## 👥 User Management Endpoints (Admin)

### Create User Account

**Endpoint:** `POST /api/users`

**Headers:**
```
Authorization: Bearer {token}
```

**Request Body:**
```json
{
  "username": "user123",
  "password": "password123",
  "name": "Nama User",
  "email": "user@example.com",
  "phone": "08123456789",
  "role": "user"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user_id",
    "username": "user123",
    "name": "Nama User",
    "email": "user@example.com"
  },
  "message": "User berhasil dibuat"
}
```

---

## 📊 Dashboard Statistics

**Endpoint:** `GET /api/dashboard/stats`

**Headers:**
```
Authorization: Bearer {token}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "total_kost": 8,
    "total_rooms": 64,
    "empty_rooms": 12,
    "occupied_rooms": 52,
    "total_tenants": 52,
    "unpaid_bills": 8,
    "pending_verification": 3
  }
}
```

---

## 🔧 Implementation di Flutter

### 1. Setup HTTP Client

Tambahkan dependency di `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
  shared_preferences: ^2.2.2
```

### 2. Create API Service

```dart
// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://your-api-url.com/api';
  
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    
    return jsonDecode(response.body);
  }
  
  // Add more methods...
}
```

### 3. Update Login Screen

```dart
// Di login_screen.dart, ganti fungsi _login():

Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ApiService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (result['success']) {
        // Save token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['data']['token']);
        await prefs.setString('role', result['data']['user']['role']);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
      } else {
        // Show error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
```

---

## 🔑 Token Management

### Save Token
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('token', token);
```

### Get Token
```dart
final prefs = await SharedPreferences.getInstance();
final token = prefs.getString('token');
```

### Remove Token (Logout)
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.remove('token');
await prefs.remove('role');
```

---

## 📝 Notes untuk Backend Developer

1. **CORS:** Pastikan backend mengizinkan request dari Flutter app
2. **Token:** Gunakan JWT dengan expiry time
3. **Error Handling:** Selalu return format JSON yang konsisten
4. **Status Code:** Gunakan HTTP status code yang sesuai (200, 201, 400, 401, 404, 500)
5. **Validation:** Validasi semua input di backend
6. **Pagination:** Untuk list data yang banyak, gunakan pagination

---

## 🧪 Testing

### Hardcoded Credentials (Development)
```
Admin:
- Username: admin
- Password: admin123

User:
- Username: user
- Password: user123
```

**PENTING:** Hapus hardcoded credentials setelah integrasi dengan backend!

---

**Last Updated:** 19 Maret 2026
