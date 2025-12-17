# 🪟 HƯỚNG DẪN CÀI ĐẶT MYSQL TRÊN WINDOWS

## 📋 Tình huống
Bạn gặp lỗi: `mysql : The term 'mysql' is not recognized` - có nghĩa là MySQL chưa được cài đặt hoặc chưa được thêm vào PATH.

---

## 🚀 CÁCH 1: CÀI ĐẶT MYSQL INSTALLER (Khuyến nghị)

### Bước 1: Tải MySQL Installer
1. Truy cập: https://dev.mysql.com/downloads/installer/
2. Chọn **MySQL Installer for Windows**
3. Tải file **mysql-installer-community** (file lớn nhất, khoảng 400MB+)

### Bước 2: Chạy Installer
1. Chạy file `.msi` vừa tải
2. Chọn **Developer Default** (bao gồm MySQL Server, MySQL Workbench, MySQL Shell)
3. Click **Execute** để cài đặt các components

### Bước 3: Cấu hình MySQL Server
1. Sau khi cài đặt, MySQL Configuration Wizard sẽ tự động mở
2. Chọn **Standalone MySQL Server / Classic MySQL Replication**
3. Chọn **Development Computer**
4. Chọn **Use Strong Password Encryption**
5. **Đặt password cho root user**: Nhập `1234` (hoặc password bạn muốn)
   - ⚠️ **QUAN TRỌNG**: Ghi nhớ password này để sử dụng trong file `.env`
6. Click **Execute** để hoàn tất cấu hình

### Bước 4: Kiểm tra cài đặt
Mở **Command Prompt mới** (quan trọng: phải mở mới để load PATH) và chạy:
```bash
mysql --version
```

Nếu hiển thị version → Thành công! ✅

---

## 🔧 CÁCH 2: THÊM MYSQL VÀO PATH (Nếu MySQL đã cài nhưng chưa có trong PATH)

### Bước 1: Tìm đường dẫn MySQL
MySQL thường được cài tại:
```
C:\Program Files\MySQL\MySQL Server 8.0\bin
```
hoặc
```
C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin
```

### Bước 2: Thêm vào PATH
1. Nhấn `Win + R`, gõ `sysdm.cpl` → Enter
2. Tab **Advanced** → Click **Environment Variables**
3. Trong **System variables**, tìm và chọn **Path** → Click **Edit**
4. Click **New** → Dán đường dẫn MySQL bin (ví dụ: `C:\Program Files\MySQL\MySQL Server 8.0\bin`)
5. Click **OK** để lưu

### Bước 3: Kiểm tra
Mở **Command Prompt mới** và chạy:
```bash
mysql --version
```

---

## 🗄️ SAU KHI CÀI ĐẶT XONG

### 1. Khởi động MySQL Service
1. Nhấn `Win + R`, gõ `services.msc` → Enter
2. Tìm service **MySQL80** hoặc **MySQL**
3. Click chuột phải → **Start** (nếu chưa chạy)

Hoặc dùng Command Prompt (với quyền Administrator):
```bash
net start MySQL80
```

### 2. Đăng nhập vào MySQL
```bash
mysql -u root -p
```
Nhập password: `1234` (hoặc password bạn đã đặt)

### 3. Tạo Database
Sau khi đăng nhập, chạy:
```sql
source D:/DoAnSinhVien/MusicApp/FresherK8/Server/MusicApp/database_setup.sql;
```

### 4. Tạo file .env
Trong thư mục dự án, tạo file `.env` với nội dung:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=1234
DB_PORT=3306
DB_NAME=musicapp_db
```

---

## 🐛 XỬ LÝ LỖI

### Lỗi: "Access denied for user 'root'@'localhost'"
**Giải pháp**: 
- Đảm bảo password trong file `.env` đúng với password bạn đã đặt khi cài MySQL
- Thử reset password MySQL

### Lỗi: "Can't connect to MySQL server"
**Giải pháp**:
- Kiểm tra MySQL service đang chạy: `services.msc`
- Khởi động service: `net start MySQL80`

### Lỗi: "mysql command not found" sau khi cài đặt
**Giải pháp**:
- Đóng và mở lại Command Prompt
- Hoặc thêm MySQL vào PATH (xem Cách 2 ở trên)
- Hoặc sử dụng đường dẫn đầy đủ: `"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p`

---

## ✅ KIỂM TRA HOÀN TẤT

Sau khi hoàn thành, bạn có thể:
1. ✅ Chạy `mysql --version` → Hiển thị version
2. ✅ Đăng nhập: `mysql -u root -p` → Nhập password thành công
3. ✅ Tạo database từ file `database_setup.sql`
4. ✅ Chạy `npm start` → Server chạy không lỗi kết nối database

---

## 📞 HỖ TRỢ THÊM

Nếu vẫn gặp vấn đề:
1. Kiểm tra MySQL đã được cài đặt: Control Panel → Programs → MySQL
2. Xem log MySQL: `C:\ProgramData\MySQL\MySQL Server 8.0\Data\*.err`
3. Thử cài đặt lại MySQL với tùy chọn "Remove" rồi cài lại

**Chúc bạn thành công! 🚀**

