# 📱 THÔNG TIN CẤU HÌNH CHO ANDROID CLIENT

## 🎯 THÔNG TIN CƠ BẢN

### Base URL

**⚠️ QUAN TRỌNG**: Android app không thể kết nối đến `localhost` hoặc `127.0.0.1` vì đây là địa chỉ của chính thiết bị Android, không phải máy tính chạy server.

#### Cách lấy IP Local của máy chạy Server:

**Windows:**
```bash
ipconfig
# Tìm "IPv4 Address" trong kết quả
# Ví dụ: 192.168.1.100 hoặc 10.50.103.255
```

**macOS/Linux:**
```bash
ifconfig
# Hoặc
ip addr show
# Tìm IP của adapter mạng (thường là wlan0 hoặc eth0)
```

#### Cấu hình Base URL:

```
Development (Local Network): http://[YOUR_LOCAL_IP]:3000/api
# Ví dụ: http://192.168.1.100:3000/api
# Hoặc: http://10.50.103.255:3000/api

Production: https://your-domain.com/api (thay đổi khi deploy)
```

#### Cập nhật Base URL trong Android App:

1. Mở file: `app/src/main/java/com/example/musicapp/shared/utils/constant/ManagerUrl.kt`
2. Thay đổi `BASE_URL`:
```kotlin
const val BASE_URL = "http://[YOUR_LOCAL_IP]:3000/api/"
// Ví dụ: const val BASE_URL = "http://192.168.1.100:3000/api/"
```

**Lưu ý**: 
- Đảm bảo máy tính chạy server và thiết bị Android đang cùng một mạng WiFi
- Nếu thay đổi IP, cần rebuild Android app

### Headers
```
Content-Type: application/json
Accept: application/json
```

### Response Format
Tất cả API trả về format:
```json
{
  "status": 200,  // hoặc "400" nếu lỗi
  "data": {...}   // tên field thay đổi theo endpoint
}
```

---

## 📋 TỔNG HỢP API ENDPOINTS

### USER
- `POST /api/user` - Tạo user mới
  - Body: `{"userId": "string"}`

### SONGS
- `GET /api/songs` - Lấy tất cả bài hát
- `GET /api/songs/playlist/:playlistId` - Lấy bài hát theo playlist
- `GET /api/songs/topic/:topicId` - Lấy bài hát theo topic
- `GET /api/songs/album/:albumId` - Lấy bài hát theo album
- `GET /api/songs/love/:userId` - Lấy bài hát yêu thích
- `POST /api/song/love` - Thêm vào yêu thích
  - Body: `{"userId": "string", "songId": int}`
- `DELETE /api/song/love/:songLoveId` - Xóa khỏi yêu thích

### PLAYLISTS
- `GET /api/playlists` - Lấy tất cả playlist
- `GET /api/playlists/mood/today` - Playlist tâm trạng hôm nay
- `GET /api/playlists/:userId` - Playlist của user
- `GET /api/playlists/love/:userId` - Playlist yêu thích
- `GET /api/playlists/songs/:playlistUserId` - Bài hát trong playlist
- `POST /api/playlist/user` - Tạo playlist mới
  - Body: `{"namePlaylist": "string", "userId": "string"}`
- `POST /api/playlist/user/song` - Thêm bài hát vào playlist
  - Body: `{"playlistUserId": int, "songId": int}`
- `POST /api/playlist/user/love` - Thêm playlist vào yêu thích
  - Body: `{"userId": "string", "playlistId": int}`
- `DELETE /api/playlistsUser?playlistUserId=[1,2,3]` - Xóa playlist (query param là JSON array string)
- `DELETE /api/playlistsLove?playlistLoveId=[1,2,3]` - Xóa playlist yêu thích

### ALBUMS
- `GET /api/albums/new` - Album mới
- `GET /api/albums/love` - Album yêu thích

### SEARCH
- `GET /api/search/:keyword` - Tìm kiếm (trả về songs, playlists, music_videos, albums)
- `GET /api/search/all/name` - Lấy tất cả tên để gợi ý

### MUSIC VIDEOS
- `GET /api/musics/video` - Lấy tất cả video
- `GET /api/musics/video/:musicVideoId` - Lấy video (loại trừ một video)

### LYRICS
- `GET /api/lyrics/:songId` - Lấy lời bài hát

### TOPICS
- `GET /api/topics` - Lấy tất cả topic
- `GET /api/topics/categories/:categoryId` - Topic theo category

### CATEGORIES
- `GET /api/categories` - Lấy tất cả category

### FOLLOW
- `POST /api/follow` - Theo dõi nghệ sĩ
  - Body: `{"userId": "string", "artistId": int}`
- `GET /api/followed/:userId/:artistId` - Kiểm tra đã follow chưa
- `GET /api/follow/quantity/:userId` - Số lượng đã follow
- `GET /api/follows/:userId` - Danh sách nghệ sĩ đã follow
- `DELETE /api/follow/:userId/:artistId` - Bỏ theo dõi

### SONG RANK
- `GET /api/songs/rank/listen` - Bảng xếp hạng

### SONG AGAIN (Lịch sử)
- `GET /api/songs/Again/:id` - Lấy lịch sử nghe (id = userId)
- `POST /api/song/again` - Thêm vào lịch sử
  - Body: `{"userId": "string", "songId": int}`

### DEEPLINK
- `GET /api/getDeeplink` - Lấy deeplink streaming

---

## 📦 CẤU TRÚC DỮ LIỆU CHÍNH

### Song
```json
{
  "song_id": 1,
  "song_name": "string",
  "song_image": "string (URL)",
  "song_url": "string (URL)",
  "name_artist": "string",
  "download": "string (optional)"
}
```

### Playlist
```json
{
  "playlist_id": 1,
  "playlist_name": "string",
  "playlist_image": "string (URL)",
  "name_artist": "string"
}
```

### Album
```json
{
  "album_id": 1,
  "album_name": "string",
  "album_image": "string (URL)",
  "name_artist": "string"
}
```

### Music Video
```json
{
  "music_video_id": 1,
  "music_video_name": "string",
  "artist_id": 1,
  "artist_name": "string",
  "artist_image": "string (URL)",
  "music_video_image": "string (URL)",
  "music_video_time": "string",
  "music_video_proposal_new": 1,
  "topic_id": 1
}
```

### Search Response
```json
{
  "status": 200,
  "search": {
    "songs": [...],
    "playlists": [...],
    "music_videos": [...],
    "albums": [...]
  }
}
```

---

## 🔗 ANDROID APP LINKS

### Package Name
```
com.example.musicapp
```

### SHA256 Fingerprint
```
8D:D1:06:52:C0:41:BF:4B:77:7E:C5:4B:F6:5E:34:F2:22:82:37:E4:C8:08:5F:3B:88:29:B7:27:D0:84:6F:77
```

### Asset Links URL
```
/.well-known/assetlinks.json
```

---

## ⚠️ LƯU Ý QUAN TRỌNG

1. **Server phải đang chạy**: Đảm bảo Node.js server đang chạy trên máy tính trước khi test Android app
   - Chạy server: `cd ../Server/MusicApp && npm start`
   - Server sẽ chạy tại: `http://localhost:3000`

2. **Cùng mạng WiFi**: Máy tính chạy server và thiết bị Android phải cùng một mạng WiFi

3. **Firewall**: Có thể cần tắt Windows Firewall hoặc cho phép Node.js qua firewall để Android có thể kết nối

4. **Không có Authentication**: API hiện tại không yêu cầu token/auth

5. **Error Handling**: Luôn kiểm tra `status` trong response (200 = success, "400" = error)

6. **Query Parameters**: Một số DELETE endpoint dùng query param là JSON array string: `?playlistUserId="[1,2,3]"`

7. **Image URLs**: Tất cả image fields là URL strings, cần load bằng Glide/Coil

8. **Base URL**: Nên dùng BuildConfig hoặc strings.xml để dễ switch dev/prod

---

## 📄 FILES THAM KHẢO

- **API_DOCUMENTATION_ANDROID.md**: Tài liệu chi tiết đầy đủ
- **android_api_config.json**: File config JSON để parse

---

## 🚀 HƯỚNG DẪN SETUP VÀ CHẠY

### Bước 1: Chạy Server Node.js

1. Mở terminal/command prompt
2. Di chuyển đến thư mục server:
```bash
cd ../Server/MusicApp
# Hoặc: cd D:\DoAnSinhVien\MusicApp\FresherK8\Server\MusicApp
```

3. Cài đặt dependencies (nếu chưa có):
```bash
npm install
```

4. Đảm bảo đã tạo file `.env` với cấu hình database (xem `README_SERVER.md`)

5. Chạy server:
```bash
npm start
```

6. Kiểm tra server đang chạy:
   - Mở trình duyệt: `http://localhost:3000/api/songs`
   - Nếu thấy JSON response → Server hoạt động ✅

### Bước 2: Lấy IP Local

**Windows:**
```bash
ipconfig
# Tìm "IPv4 Address"
```

**macOS/Linux:**
```bash
ifconfig
```

### Bước 3: Cập nhật Base URL trong Android App

1. Mở file: `app/src/main/java/com/example/musicapp/shared/utils/constant/ManagerUrl.kt`
2. Cập nhật `BASE_URL` với IP vừa lấy:
```kotlin
const val BASE_URL = "http://[YOUR_IP]:3000/api/"
```

### Bước 4: Build và chạy Android App

1. Rebuild project trong Android Studio
2. Chạy app trên thiết bị hoặc emulator
3. Đảm bảo thiết bị Android và máy tính cùng mạng WiFi

### Bước 5: Test kết nối

- Nếu app có thể load dữ liệu từ API → Thành công! ✅
- Nếu không kết nối được, kiểm tra:
  - Server đang chạy
  - IP đúng
  - Cùng mạng WiFi
  - Firewall không chặn

---

**Sử dụng thông tin này để cấu hình Android client với Retrofit/OkHttp**

