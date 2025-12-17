# 🌐 HƯỚNG DẪN KẾT NỐI ANDROID VỚI SERVER QUA IP

## ❗ Vấn đề
Android app không thể kết nối đến `localhost` hoặc `127.0.0.1` vì đây là địa chỉ của chính thiết bị Android, không phải máy tính chạy server.

## ✅ Giải pháp
Sử dụng địa chỉ IP của máy tính thay vì `localhost`.

---

## 📋 BƯỚC 1: LẤY ĐỊA CHỈ IP CỦA MÁY TÍNH

### Cách 1: Sử dụng script Node.js (Khuyến nghị)
```bash
node get-ip.js
```

Script sẽ hiển thị tất cả IP addresses của máy tính.

### Cách 2: Sử dụng Command Prompt (Windows)
```bash
ipconfig
```

Tìm dòng **IPv4 Address** trong phần **Wireless LAN adapter Wi-Fi** hoặc **Ethernet adapter**.

Ví dụ:
```
Wireless LAN adapter Wi-Fi:
   IPv4 Address. . . . . . . . . . . : 192.168.1.100
```

### Cách 3: Sử dụng PowerShell (Windows)
```powershell
Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*"} | Select-Object IPAddress, InterfaceAlias
```

### Cách 4: Sử dụng Terminal (macOS/Linux)
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

hoặc

```bash
ip addr show | grep "inet " | grep -v 127.0.0.1
```

---

## 🚀 BƯỚC 2: KHỞI ĐỘNG SERVER

Server đã được cấu hình để tự động hiển thị IP khi khởi động:

```bash
npm start
```

Bạn sẽ thấy output như sau:
```
🚀 Server đang chạy!
📍 Local:   http://localhost:3000
🌐 Network: http://192.168.1.100:3000
📱 Android: Sử dụng URL: http://192.168.1.100:3000/api

⚠️  Đảm bảo Android device và máy tính cùng mạng WiFi!
```

**Lưu ý**: IP hiển thị là IP của máy tính, sử dụng IP này trong Android app.

---

## 📱 BƯỚC 3: CẤU HÌNH ANDROID APP

### Thay đổi Base URL trong Android

#### Cách 1: Sử dụng BuildConfig (Khuyến nghị)

**app/build.gradle**:
```gradle
android {
    buildTypes {
        debug {
            buildConfigField "String", "BASE_URL", '"http://192.168.1.100:3000/api"'
            // Thay 192.168.1.100 bằng IP của máy bạn
        }
        release {
            buildConfigField "String", "BASE_URL", '"https://your-domain.com/api"'
        }
    }
}
```

**Sử dụng trong code**:
```kotlin
val baseUrl = BuildConfig.BASE_URL
```

#### Cách 2: Sử dụng strings.xml

**res/values/strings.xml**:
```xml
<string name="base_url">http://192.168.1.100:3000/api</string>
```

**Sử dụng trong code**:
```kotlin
val baseUrl = getString(R.string.base_url)
```

#### Cách 3: Sử dụng Retrofit

**ApiClient.kt**:
```kotlin
object ApiClient {
    private const val BASE_URL = "http://192.168.1.100:3000/api"
    // Thay 192.168.1.100 bằng IP của máy bạn
    
    val retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
    
    val apiService: ApiService = retrofit.create(ApiService::class.java)
}
```

---

## 🔒 BƯỚC 4: CẤU HÌNH NETWORK SECURITY (Nếu cần)

Nếu Android app không thể kết nối qua HTTP (không phải HTTPS), cần cấu hình Network Security Config.

### Tạo file: res/xml/network_security_config.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">192.168.1.100</domain>
        <!-- Thay bằng IP của máy bạn -->
        <domain includeSubdomains="true">localhost</domain>
        <domain includeSubdomains="true">10.0.2.2</domain>
        <!-- 10.0.2.2 là IP của máy host khi dùng Android Emulator -->
    </domain-config>
</network-security-config>
```

### Thêm vào AndroidManifest.xml
```xml
<application
    android:networkSecurityConfig="@xml/network_security_config"
    ...>
    ...
</application>
```

---

## 🧪 BƯỚC 5: KIỂM TRA KẾT NỐI

### Từ Android device/emulator:

1. **Mở trình duyệt trên Android** và truy cập:
   ```
   http://192.168.1.100:3000/api/songs
   ```
   (Thay IP bằng IP của máy bạn)

2. **Nếu thấy JSON response** → Kết nối thành công! ✅

3. **Nếu không kết nối được**, kiểm tra:
   - ✅ Android device và máy tính cùng mạng WiFi
   - ✅ Firewall không chặn port 3000
   - ✅ Server đang chạy
   - ✅ IP address đúng

### Từ máy tính:
```bash
curl http://192.168.1.100:3000/api/songs
```

---

## 🔥 CẤU HÌNH FIREWALL (Windows)

Nếu Android không kết nối được, có thể do Firewall chặn:

### Mở port 3000 trong Windows Firewall:

1. Mở **Windows Defender Firewall**
2. Click **Advanced settings**
3. Click **Inbound Rules** → **New Rule**
4. Chọn **Port** → **Next**
5. Chọn **TCP**, nhập **3000** → **Next**
6. Chọn **Allow the connection** → **Next**
7. Chọn tất cả profiles → **Next**
8. Đặt tên: "Node.js Server" → **Finish**

Hoặc sử dụng PowerShell (với quyền Administrator):
```powershell
New-NetFirewallRule -DisplayName "Node.js Server" -Direction Inbound -LocalPort 3000 -Protocol TCP -Action Allow
```

---

## 📱 SỬ DỤNG VỚI ANDROID EMULATOR

Nếu dùng **Android Emulator** (Android Studio AVD):

- **Không dùng IP thực**, mà dùng: `10.0.2.2`
- Đây là IP đặc biệt của Android Emulator trỏ về localhost của máy host

**Base URL cho Emulator**:
```
http://10.0.2.2:3000/api
```

---

## 🌐 SỬ DỤNG VỚI THIẾT BỊ THẬT

Khi dùng **thiết bị Android thật**:

1. **Đảm bảo cùng WiFi**: Máy tính và Android device phải cùng mạng WiFi
2. **Sử dụng IP thực**: Dùng IP từ `ipconfig` hoặc `get-ip.js`
3. **Kiểm tra Firewall**: Đảm bảo Firewall cho phép kết nối

---

## 🔄 IP THAY ĐỔI

**Lưu ý**: IP có thể thay đổi mỗi khi kết nối lại WiFi. Nếu IP thay đổi:

1. Chạy lại `node get-ip.js` để lấy IP mới
2. Cập nhật Base URL trong Android app
3. Rebuild app

**Giải pháp tốt hơn**: Sử dụng static IP hoặc DHCP reservation trong router.

---

## 📝 TÓM TẮT

1. ✅ Lấy IP: `node get-ip.js` hoặc `ipconfig`
2. ✅ Khởi động server: `npm start` (sẽ hiển thị IP)
3. ✅ Cập nhật Base URL trong Android: `http://YOUR_IP:3000/api`
4. ✅ Cấu hình Network Security Config (nếu cần)
5. ✅ Mở Firewall port 3000 (nếu cần)
6. ✅ Test kết nối từ trình duyệt Android

---

## 🐛 TROUBLESHOOTING

### Lỗi: "Connection refused"
- ✅ Kiểm tra server đang chạy
- ✅ Kiểm tra IP đúng
- ✅ Kiểm tra Firewall

### Lỗi: "Network is unreachable"
- ✅ Kiểm tra cùng WiFi
- ✅ Ping từ Android: `ping 192.168.1.100`

### Lỗi: "Cleartext HTTP traffic not permitted"
- ✅ Thêm Network Security Config (xem Bước 4)

### Emulator không kết nối được
- ✅ Dùng `10.0.2.2` thay vì IP thực
- ✅ Không dùng `localhost` hoặc `127.0.0.1`

---

**Chúc bạn kết nối thành công! 🚀**

