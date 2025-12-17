# 📚 HƯỚNG DẪN CHI TIẾT TẠO DATABASE MYSQL

## 🎯 Mục tiêu
Hướng dẫn từng bước để tạo database MySQL cho dự án Music App.

---

## 📋 BƯỚC 1: KIỂM TRA VÀ CÀI ĐẶT MYSQL

### 1.1. Kiểm tra MySQL đã được cài đặt chưa

Mở Command Prompt (Windows) hoặc Terminal (macOS/Linux) và chạy:
```bash
mysql --version
```

Nếu hiển thị version (ví dụ: `mysql  Ver 8.0.xx`), bạn đã có MySQL. Nếu không, cần cài đặt.

### 1.2. Cài đặt MySQL (nếu chưa có)

#### **Windows:**
1. Truy cập: https://dev.mysql.com/downloads/installer/
2. Tải **MySQL Installer for Windows**
3. Chạy installer và chọn "Developer Default"
4. Trong quá trình cài đặt, ghi nhớ **root password** bạn đặt (1234)

#### **macOS:**
```bash
# Sử dụng Homebrew
brew install mysql

# Hoặc tải từ: https://dev.mysql.com/downloads/mysql/
```

#### **Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install mysql-server
sudo mysql_secure_installation
```

---

## 🔧 BƯỚC 2: KHỞI ĐỘNG MYSQL SERVER

### Windows:
1. Nhấn `Win + R`, gõ `services.msc`
2. Tìm service **MySQL80** hoặc **MySQL**
3. Click chuột phải → **Start**

Hoặc sử dụng Command Prompt (với quyền Administrator):
```bash
net start MySQL80
```

### macOS:
```bash
brew services start mysql
# hoặc
sudo /usr/local/mysql/support-files/mysql.server start
```

### Linux:
```bash
sudo systemctl start mysql
# hoặc
sudo service mysql start
```

### Kiểm tra MySQL đang chạy:
```bash
# Windows
netstat -an | findstr 3306

# macOS/Linux
sudo netstat -an | grep 3306
```

---

## 🔐 BƯỚC 3: ĐĂNG NHẬP VÀO MYSQL

Mở Command Prompt/Terminal và chạy:

```bash
mysql -u root -p
```

Nhập password của root user khi được yêu cầu.

**Lưu ý**: 
- Nếu MySQL mới cài và chưa đặt password, có thể bỏ qua `-p`
- Nếu gặp lỗi "Access denied", thử: `mysql -u root -p` và nhập password
- Trên Linux, có thể cần: `sudo mysql -u root -p`

---

## 🗄️ BƯỚC 4: TẠO DATABASE VÀ CÁC BẢNG

### Cách 1: Sử dụng file SQL script (Khuyến nghị - Dễ nhất)

#### 4.1. Xác định đường dẫn file SQL

File `database_setup.sql` nằm trong thư mục dự án:
```
D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp\database_setup.sql
```

#### 4.2. Chạy script SQL

**Trong MySQL command line:**

```sql
-- Thay đổi đường dẫn cho phù hợp với máy bạn
source D:/LapTrinhDiDong/CuoiKy/Server/database_setup.sql;
```

**Hoặc từ Command Prompt/Terminal (bên ngoài MySQL):**

```bash
# Windows
mysql -u root -p < D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp\database_setup.sql

# macOS/Linux
mysql -u root -p < /path/to/database_setup.sql
```

**Lưu ý**: 
- Trong MySQL command line, dùng dấu `/` cho đường dẫn
- Trong Command Prompt/Terminal, dùng dấu `\` cho Windows, `/` cho macOS/Linux

### Cách 2: Tạo thủ công từng bước

Nếu muốn hiểu rõ hơn, bạn có thể chạy từng lệnh:

```sql
-- 1. Tạo database
CREATE DATABASE IF NOT EXISTS musicapp_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 2. Sử dụng database
USE musicapp_db;

-- 3. Tạo các bảng (copy toàn bộ nội dung từ file database_setup.sql)
-- ... (xem file database_setup.sql)
```

---

## ✅ BƯỚC 5: KIỂM TRA DATABASE ĐÃ ĐƯỢC TẠO

Trong MySQL command line, chạy các lệnh sau:

```sql
-- Xem danh sách database
SHOW DATABASES;

-- Chọn database
USE musicapp_db;

-- Xem danh sách bảng
SHOW TABLES;

-- Xem cấu trúc một bảng (ví dụ: User)
DESCRIBE User;

-- Xem dữ liệu của một bảng (ví dụ: bảng User)
SELECT * FROM User;
```

Bạn sẽ thấy các bảng sau:
- ✅ User
- ✅ Category
- ✅ Topic
- ✅ Artist
- ✅ Album
- ✅ Playlist
- ✅ Song
- ✅ song_love
- ✅ playlist_user
- ✅ playlist_user_song
- ✅ playlist_user_love
- ✅ Music_Video
- ✅ LYRIC
- ✅ FOLLOW
- ✅ album_love

---

## ⚙️ BƯỚC 6: CẤU HÌNH FILE .ENV

### 6.1. Tạo file .env

Trong thư mục gốc của dự án (`MusicApp`), tạo file mới tên `.env`

### 6.2. Thêm nội dung vào file .env

```env
DB_HOST=localhost
DB_USER=root
DB_PORT=3306
DB_NAME=musicapp_db
```

### 6.3. Nếu MySQL yêu cầu password

Nếu MySQL của bạn yêu cầu password, bạn cần:

1. **Thêm password vào file .env:**
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password_here
DB_PORT=3306
DB_NAME=musicapp_db
```

2. **Cập nhật file `database/database.js`:**

Mở file `database/database.js` và sửa thành:

```javascript
require('dotenv').config();
const mysql = require('mysql2');

const con = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,  // Thêm dòng này
    port: process.env.DB_PORT,
    database: process.env.DB_NAME
});

// ... phần còn lại giữ nguyên
```

---

## 🧪 BƯỚC 7: KIỂM TRA KẾT NỐI

### 7.1. Test kết nối từ MySQL

```sql
USE musicapp_db;
SELECT DATABASE();
```

Nếu hiển thị `musicapp_db` → Database hoạt động tốt!

### 7.2. Test kết nối từ Node.js

1. Chạy ứng dụng:
```bash
npm start
```

2. Nếu không có lỗi kết nối database → Thành công! ✅

3. Nếu có lỗi, kiểm tra:
   - ✅ MySQL server đang chạy
   - ✅ File `.env` đã được tạo và đúng đường dẫn
   - ✅ Thông tin trong `.env` đúng
   - ✅ Database `musicapp_db` đã được tạo
   - ✅ User MySQL có quyền truy cập

---

## 🐛 XỬ LÝ LỖI THƯỜNG GẶP

### Lỗi 1: "Access denied for user"
**Nguyên nhân**: Sai username hoặc password
**Giải pháp**: 
- Kiểm tra lại `DB_USER` và `DB_PASSWORD` trong file `.env`
- Đảm bảo user có quyền truy cập database

### Lỗi 2: "Unknown database 'musicapp_db'"
**Nguyên nhân**: Database chưa được tạo
**Giải pháp**: Chạy lại file `database_setup.sql`

### Lỗi 3: "Can't connect to MySQL server"
**Nguyên nhân**: MySQL server chưa khởi động
**Giải pháp**: Khởi động MySQL service (xem Bước 2)

### Lỗi 4: "Table doesn't exist"
**Nguyên nhân**: Các bảng chưa được tạo
**Giải pháp**: Chạy lại phần tạo bảng trong `database_setup.sql`

### Lỗi 5: "Port 3306 is already in use"
**Nguyên nhân**: Port đã được sử dụng
**Giải pháp**: 
- Kiểm tra MySQL đang chạy: `netstat -an | findstr 3306`
- Hoặc thay đổi port trong file `.env` và cấu hình MySQL

---

## 📊 CẤU TRÚC DATABASE

### Sơ đồ quan hệ các bảng:

```
User
  ├── song_love (user_id → song_id)
  ├── playlist_user (user_id)
  └── FOLLOW (user_id → artist_id)

Song
  ├── song_love (song_id)
  ├── playlist_user_song (song_id)
  ├── LYRIC (song_id)
  └── album_love (song_id)
  └── Album (album_id)
  └── Playlist (playlist_id)
  └── Topic (topic_id)

Album
  └── Song (album_id)

Playlist
  ├── Song (playlist_id)
  └── playlist_user_love (playlist_id)

Artist
  ├── Music_Video (artist_id)
  └── FOLLOW (artist_id)

Topic
  ├── Song (topic_id)
  ├── Music_Video (topic_id)
  └── Category (category_id)

Category
  └── Topic (category_id)
```

---

## 🎉 HOÀN TẤT!

Sau khi hoàn thành tất cả các bước trên, bạn đã sẵn sàng để chạy ứng dụng!

Chạy lệnh:
```bash
npm start
```

Server sẽ chạy tại: `http://localhost:3000`

---

## 📞 HỖ TRỢ

Nếu gặp vấn đề, kiểm tra:
1. ✅ MySQL server đang chạy
2. ✅ Database và các bảng đã được tạo
3. ✅ File `.env` đã được cấu hình đúng
4. ✅ Dependencies đã được cài đặt (`npm install`)

**Chúc bạn thành công! 🚀**

