# 🎵 Music App - Backend Server

## 📋 Tổng quan dự án

Đây là một ứng dụng backend cho ứng dụng nghe nhạc được xây dựng bằng Node.js và Express.js. Dự án cung cấp các API RESTful để quản lý người dùng, bài hát, playlist, album, video âm nhạc, lời bài hát và nhiều tính năng khác.

## 🛠️ Công nghệ sử dụng

- **Node.js**: Runtime environment
- **Express.js**: Web framework
- **MySQL2**: Database driver cho MySQL
- **Body-parser**: Middleware để parse request body
- **Dotenv**: Quản lý biến môi trường
- **Nodemon**: Tự động restart server khi code thay đổi

## 📁 Cấu trúc dự án

**⚠️ Lưu ý**: Code server Node.js nằm trong thư mục `Server/MusicApp/`, không phải thư mục Android app.

```
FresherK8/
├── MusicApp/                    # Android App (Kotlin)
│   ├── app/
│   └── ...
│
└── Server/                      # Backend Server (Node.js)
    └── MusicApp/
        ├── controllers/          # Xử lý logic nghiệp vụ
        │   ├── albumController.js
        │   ├── categoryController.js
        │   ├── follow_Controller.js
        │   ├── lyric.controller.js
        │   ├── musicVideoControllers.js
        │   ├── playlistController.js
        │   ├── search.controller.js
        │   ├── songAgainController.js
        │   ├── songController.js
        │   ├── songRankController.js
        │   ├── topicController.js
        │   └── userController.js
        ├── models/              # Tương tác với database
        │   ├── albumModel.js
        │   ├── categoryModel.js
        │   ├── follow_model.js
        │   ├── lyric.model.js
        │   ├── musicVideoModel.js
        │   ├── playlistModel.js
        │   ├── search.model.js
        │   ├── songAgainModel.js
        │   ├── songModel.js
        │   ├── songRankModel.js
        │   ├── topicModel.js
        │   └── userModel.js
        ├── routers/             # Định nghĩa các routes API
        │   ├── albumRouter.js
        │   ├── categoryRouter.js
        │   ├── follow_router.js
        │   ├── lyric.router.js
        │   ├── musicVideoRouter.js
        │   ├── playlistRoter.js
        │   ├── search.router.js
        │   ├── songAgainRouter.js
        │   ├── songRankRouter.js
        │   ├── songRouter.js
        │   ├── topicRouter.js
        │   └── userRouter.js
        ├── database/            # Cấu hình kết nối database
        │   └── database.js
        ├── database_setup.sql   # Script tạo database và bảng
        ├── index.js             # File entry point của ứng dụng
        ├── package.json         # Dependencies và scripts
        ├── .env                 # File cấu hình môi trường (tạo mới)
        └── README.md            # Tài liệu dự án
```

**Đường dẫn đầy đủ:**
```
D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp\
```

## ✨ Tính năng chính

### 1. **Quản lý Người dùng (User)**
- Tạo tài khoản người dùng mới

### 2. **Quản lý Bài hát (Song)**
- Lấy danh sách tất cả bài hát
- Lấy bài hát theo playlist
- Lấy bài hát theo topic/chủ đề
- Lấy bài hát theo album
- Lấy danh sách bài hát yêu thích của người dùng
- Thêm/xóa bài hát yêu thích

### 3. **Quản lý Playlist**
- Lấy danh sách playlist
- Lấy playlist theo tâm trạng hôm nay
- Tạo playlist của người dùng
- Lấy playlist của người dùng
- Lấy danh sách bài hát trong playlist
- Thêm bài hát vào playlist
- Xóa playlist
- Quản lý playlist yêu thích

### 4. **Quản lý Album**
- Lấy danh sách album mới
- Lấy danh sách album yêu thích

### 5. **Tìm kiếm (Search)**
- Tìm kiếm theo từ khóa (songs, playlists, music videos, albums)
- Lấy tất cả tên để gợi ý tìm kiếm

### 6. **Video Âm nhạc (Music Video)**
- Quản lý video âm nhạc

### 7. **Lời bài hát (Lyric)**
- Quản lý lời bài hát

### 8. **Chủ đề/Topic**
- Quản lý các chủ đề âm nhạc

### 9. **Danh mục (Category)**
- Quản lý danh mục âm nhạc

### 10. **Bảng xếp hạng (Song Rank)**
- Quản lý bảng xếp hạng bài hát

### 11. **Theo dõi (Follow)**
- Quản lý theo dõi nghệ sĩ/người dùng

### 12. **Nghe lại (Song Again)**
- Quản lý lịch sử nghe nhạc

## 🗄️ Cấu hình Database

Dự án sử dụng MySQL làm database. 

> 📖 **Xem hướng dẫn chi tiết từng bước**: [DATABASE_SETUP_GUIDE.md](./DATABASE_SETUP_GUIDE.md)

Bạn cần thực hiện các bước sau để thiết lập database:

### Bước 1: Cài đặt MySQL

Nếu chưa có MySQL, bạn cần cài đặt:
- **Windows**: Tải MySQL Installer từ [mysql.com](https://dev.mysql.com/downloads/installer/)
- **macOS**: `brew install mysql` hoặc tải từ [mysql.com](https://dev.mysql.com/downloads/mysql/)
- **Linux**: `sudo apt-get install mysql-server` (Ubuntu/Debian) hoặc `sudo yum install mysql-server` (CentOS/RHEL)

### Bước 2: Khởi động MySQL Server

**Windows:**
- Mở Services (services.msc) và khởi động MySQL80 hoặc MySQL service
- Hoặc sử dụng MySQL Command Line Client

**macOS/Linux:**
```bash
sudo systemctl start mysql
# hoặc
sudo service mysql start
```

### Bước 3: Đăng nhập vào MySQL

Mở terminal/command prompt và đăng nhập:
```bash
mysql -u root -p
```
Nhập password của MySQL root user khi được yêu cầu.

### Bước 4: Tạo Database và các bảng

Có 2 cách để tạo database:

#### **Cách 1: Sử dụng file SQL script (Khuyến nghị)**

1. **Xác định đường dẫn file SQL:**
   File `database_setup.sql` nằm trong thư mục server:
   ```
   D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp\database_setup.sql
   ```

2. **Trong MySQL command line, chạy lệnh:**
```sql
source D:/DoAnSinhVien/MusicApp/FresherK8/Server/MusicApp/database_setup.sql;
```

**Lưu ý**: 
- Thay đổi đường dẫn cho phù hợp với vị trí file `database_setup.sql` trên máy bạn
- Trong MySQL command line, dùng dấu `/` cho đường dẫn

3. **Hoặc từ Command Prompt/Terminal (bên ngoài MySQL):**
```bash
# Windows
mysql -u root -p < D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp\database_setup.sql

# macOS/Linux
mysql -u root -p < /path/to/Server/MusicApp/database_setup.sql
```

> 📖 **Xem hướng dẫn chi tiết từng bước**: [DATABASE_SETUP_GUIDE.md](../Server/MusicApp/DATABASE_SETUP_GUIDE.md)

#### **Cách 2: Tạo thủ công từng bước**

1. Tạo database:
```sql
CREATE DATABASE IF NOT EXISTS musicapp_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE musicapp_db;
```

2. Chạy toàn bộ nội dung file `database_setup.sql` trong MySQL command line.

### Bước 5: Kiểm tra Database đã được tạo

```sql
SHOW DATABASES;
USE musicapp_db;
SHOW TABLES;
```

Bạn sẽ thấy các bảng sau:
- User
- Category
- Topic
- Artist
- Album
- Playlist
- Song
- song_love
- playlist_user
- playlist_user_song
- playlist_user_love
- Music_Video
- LYRIC
- FOLLOW
- album_love

### Bước 6: Tạo file `.env`

**Quan trọng**: Tạo file `.env` trong thư mục **Server/MusicApp** (không phải thư mục Android app)

1. **Di chuyển đến thư mục server:**
```bash
cd ../Server/MusicApp
```

2. **Tạo file `.env`** với nội dung:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=1234
DB_PORT=3306
DB_NAME=musicapp_db
```

**Lưu ý quan trọng**: 
- Thay `root` bằng username MySQL của bạn nếu khác
- Thay `1234` bằng password MySQL của bạn (hoặc để trống nếu không có password)
- File `.env` không nên được commit lên git (thêm vào `.gitignore`)
- File `database/database.js` đã được cấu hình sẵn để đọc `DB_PASSWORD` từ `.env`

### Bước 7: Kiểm tra kết nối Database

Sau khi cấu hình xong, chạy ứng dụng và kiểm tra xem có kết nối được database không. Nếu có lỗi, kiểm tra lại:
- MySQL server đang chạy
- Thông tin trong file `.env` đúng
- Database `musicapp_db` đã được tạo
- User MySQL có quyền truy cập database

### 📝 Cấu trúc Database

Database bao gồm các bảng chính:
- **User**: Quản lý người dùng
- **Song**: Bài hát
- **Album**: Album nhạc
- **Playlist**: Danh sách phát
- **Artist**: Nghệ sĩ
- **Topic**: Chủ đề âm nhạc
- **Category**: Danh mục
- **Music_Video**: Video âm nhạc
- **LYRIC**: Lời bài hát
- **song_love**: Bài hát yêu thích
- **playlist_user**: Playlist của người dùng
- **playlist_user_song**: Bài hát trong playlist người dùng
- **playlist_user_love**: Playlist yêu thích
- **FOLLOW**: Theo dõi nghệ sĩ
- **album_love**: Album yêu thích

## 🚀 Cài đặt và Chạy dự án

### Bước 1: Di chuyển đến thư mục Server
```bash
# Từ thư mục gốc MusicApp
cd ../Server/MusicApp

# Hoặc nếu bạn đang ở thư mục khác, điều hướng đến:
# D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp
```

### Bước 2: Cài đặt dependencies
```bash
npm install
```

Lệnh này sẽ cài đặt tất cả các package cần thiết:
- express
- mysql2
- body-parser
- dotenv
- nodemon

### Bước 3: Cấu hình môi trường

**Quan trọng**: Tạo file `.env` trong thư mục **Server/MusicApp** (nơi có file `index.js`)

Tạo file `.env` với nội dung:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=1234
DB_PORT=3306
DB_NAME=musicapp_db
```

**Lưu ý**: 
- Thay `1234` bằng password MySQL của bạn (hoặc xóa dòng `DB_PASSWORD` nếu không có password)
- Đảm bảo bạn đã tạo database MySQL trước khi chạy ứng dụng (xem phần "Cấu hình Database" ở trên)

### Bước 4: Chạy ứng dụng

#### Cách 1: Sử dụng npm script (khuyến nghị)
```bash
npm start
```

Script này sử dụng `nodemon` để tự động restart server khi có thay đổi code.

#### Cách 2: Chạy trực tiếp với Node.js
```bash
node index.js
```

### Bước 5: Kiểm tra server
Sau khi chạy thành công, bạn sẽ thấy thông báo:
```
Example app listening on port 3000
```

Server sẽ chạy tại: `http://localhost:3000`

### Bước 6: Test kết nối API

Mở trình duyệt hoặc dùng Postman/curl để test:

```bash
# Test API lấy danh sách bài hát
curl http://localhost:3000/api/songs

# Hoặc mở trình duyệt và truy cập:
# http://localhost:3000/api/songs
```

Nếu nhận được response JSON → Server hoạt động tốt! ✅

### Bước 7: Lấy IP local để Android kết nối

**Windows:**
```bash
ipconfig
# Tìm "IPv4 Address" (ví dụ: 192.168.1.100 hoặc 10.50.103.255)
```

**macOS/Linux:**
```bash
ifconfig
# Hoặc
ip addr show
# Tìm IP của adapter mạng (thường là wlan0 hoặc eth0)
```

Sau đó cập nhật Base URL trong Android app (xem `ANDROID_CLIENT_SETUP.md`)

## 📡 API Endpoints

Tất cả các API endpoints đều có prefix `/api`

### User APIs
- `POST /api/user` - Tạo người dùng mới

### Song APIs
- `GET /api/songs` - Lấy danh sách tất cả bài hát
- `GET /api/songs/playlist/:playlistId` - Lấy bài hát theo playlist
- `GET /api/songs/topic/:topicId` - Lấy bài hát theo topic
- `GET /api/songs/album/:albumId` - Lấy bài hát theo album
- `GET /api/songs/love/:userId` - Lấy bài hát yêu thích của user
- `POST /api/song/love` - Thêm bài hát vào yêu thích
- `DELETE /api/song/love/:songLoveId` - Xóa bài hát khỏi yêu thích

### Playlist APIs
- `GET /api/playlists` - Lấy danh sách playlist
- `GET /api/playlists/mood-today` - Lấy playlist theo tâm trạng hôm nay
- `GET /api/playlists/user/:userId` - Lấy playlist của user
- `GET /api/playlists/love/:userId` - Lấy playlist yêu thích của user
- `POST /api/playlist/user` - Tạo playlist mới
- `POST /api/playlist/love` - Thêm playlist vào yêu thích
- `GET /api/playlist/songs/:playlistUserId` - Lấy bài hát trong playlist
- `POST /api/playlist/song` - Thêm bài hát vào playlist
- `DELETE /api/playlist/user` - Xóa playlist của user
- `DELETE /api/playlist/love` - Xóa playlist khỏi yêu thích

### Album APIs
- `GET /api/albums/new` - Lấy danh sách album mới
- `GET /api/albums/love` - Lấy danh sách album yêu thích

### Search APIs
- `GET /api/search/:keyword` - Tìm kiếm theo từ khóa
- `GET /api/search/all/names` - Lấy tất cả tên để gợi ý

### Other APIs
- `GET /api/getDeeplink` - Lấy deeplink cho streaming
- `GET /.well-known/assetlinks.json` - Android App Links configuration

## 🔧 Cấu trúc Code

### Pattern: MVC (Model-View-Controller)

1. **Router** (`routers/`): Định nghĩa các routes và mapping với controllers
2. **Controller** (`controllers/`): Xử lý logic nghiệp vụ, nhận request và trả về response
3. **Model** (`models/`): Tương tác trực tiếp với database, thực hiện các query SQL

### Luồng xử lý request:
```
Client Request → Router → Controller → Model → Database
                                    ↓
Client Response ← Router ← Controller ← Model ← Database
```

## ⚠️ Lưu ý quan trọng

1. **Database Connection**: Đảm bảo MySQL server đang chạy và database đã được tạo
2. **Environment Variables**: File `.env` là bắt buộc, không commit file này lên git
3. **Port**: Server mặc định chạy trên port 3000, có thể thay đổi trong `index.js`
4. **CORS**: Hiện tại dự án chưa có cấu hình CORS, nếu cần gọi API từ frontend, cần thêm middleware CORS

## 📝 Ví dụ Request/Response

### Tạo người dùng mới
**Request:**
```http
POST /api/user
Content-Type: application/json

{
  "userId": "user123"
}
```

**Response:**
```json
{
  "status": 200,
  "user": {...}
}
```

### Lấy danh sách bài hát
**Request:**
```http
GET /api/songs
```

**Response:**
```json
{
  "status": 200,
  "songs": [...]
}
```

## 🧪 KIỂM TRA VÀ TEST SERVER

### Kiểm tra Server đang chạy

1. **Kiểm tra log console:**
   - Nếu thấy: `Example app listening on port 3000` → Server đang chạy ✅

2. **Test API bằng trình duyệt:**
   ```
   http://localhost:3000/api/songs
   ```
   - Nếu thấy JSON response → Server hoạt động tốt ✅

3. **Test API bằng curl (Command Prompt/Terminal):**
   ```bash
   curl http://localhost:3000/api/songs
   ```

4. **Test các endpoint khác:**
   ```bash
   # Lấy danh sách playlist
   curl http://localhost:3000/api/playlists
   
   # Lấy danh sách topics
   curl http://localhost:3000/api/topics
   
   # Lấy danh sách categories
   curl http://localhost:3000/api/categories
   ```

### Kiểm tra kết nối Database

1. **Kiểm tra log khi start server:**
   - Nếu không có lỗi kết nối database → Kết nối thành công ✅
   - Nếu có lỗi "Access denied" hoặc "Can't connect" → Xem phần Troubleshooting

2. **Test query database trực tiếp:**
   - Mở MySQL command line
   - Chạy: `USE musicapp_db; SELECT COUNT(*) FROM Song;`
   - Nếu trả về số lượng → Database hoạt động tốt ✅

### Lấy IP Local để Android kết nối

**Windows:**
```bash
ipconfig
# Tìm "IPv4 Address" (ví dụ: 192.168.1.100)
```

**macOS/Linux:**
```bash
ifconfig
# Hoặc
ip addr show
```

Sau đó cập nhật Base URL trong Android app (xem `ANDROID_CLIENT_SETUP.md`)

### Test từ Android App

1. Đảm bảo server đang chạy
2. Đảm bảo Android device và máy tính cùng mạng WiFi
3. Cập nhật Base URL trong Android app với IP local
4. Chạy app và test các API calls

## 🐛 Troubleshooting

### Lỗi kết nối database
- ✅ Kiểm tra MySQL server đang chạy
- ✅ Kiểm tra thông tin trong file `.env` (đặc biệt là `DB_PASSWORD`)
- ✅ Kiểm tra database `musicapp_db` đã được tạo chưa
- ✅ Kiểm tra user MySQL có quyền truy cập database

### Port đã được sử dụng
- Thay đổi port trong `index.js` (dòng 61) hoặc
- Dừng ứng dụng đang sử dụng port 3000:
  ```bash
  # Windows
  netstat -ano | findstr :3000
  taskkill /PID [PID_NUMBER] /F
  
  # macOS/Linux
  lsof -ti:3000 | xargs kill
  ```

### Module not found
- Chạy lại `npm install` trong thư mục `Server/MusicApp`
- Kiểm tra `node_modules` folder có tồn tại
- Đảm bảo đang ở đúng thư mục khi chạy `npm install`

### Android không kết nối được server
- ✅ Đảm bảo server đang chạy
- ✅ Đảm bảo IP local đúng (không dùng `localhost` hoặc `127.0.0.1`)
- ✅ Đảm bảo Android device và máy tính cùng mạng WiFi
- ✅ Kiểm tra Windows Firewall không chặn port 3000
- ✅ Test API từ trình duyệt trên máy tính trước

### Lỗi "Access denied for user"
- Kiểm tra `DB_USER` và `DB_PASSWORD` trong file `.env`
- Đảm bảo user MySQL có quyền truy cập database
- Thử đăng nhập MySQL với thông tin trong `.env`:
  ```bash
  mysql -u root -p
  # Nhập password từ .env
  ```

### 📝 Ví dụ file .env

File `.env` nên được đặt trong thư mục `Server/MusicApp/`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=1234
DB_PORT=3306
DB_NAME=musicapp_db
```

**Lưu ý**: Thay đổi các giá trị cho phù hợp với cấu hình MySQL của bạn.

## 📄 License

ISC

## 👥 Tác giả

Dự án được phát triển bởi FresherK8 Team

---

**Chúc bạn code vui vẻ! 🎉**

