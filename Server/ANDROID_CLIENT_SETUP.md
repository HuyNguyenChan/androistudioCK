# 📱 THÔNG TIN CẤU HÌNH CHO ANDROID CLIENT

## 🎯 THÔNG TIN CƠ BẢN

### Base URL

**⚠️ QUAN TRỌNG**: Android không thể kết nối đến `localhost`! Phải dùng IP của máy tính.

#### Lấy IP của máy tính:
```bash
# Chạy script
node get-ip.js

# Hoặc Windows
ipconfig

# Hoặc macOS/Linux
ifconfig | grep "inet "
```

#### Base URL cho Android:
```
Development (Thiết bị thật): http://YOUR_IP:3000/api
Development (Emulator):      http://10.0.2.2:3000/api
Production:                   https://your-domain.com/api
```

**Ví dụ**: Nếu IP máy là `192.168.1.100`:
```
http://192.168.1.100:3000/api
```

**Lưu ý**: 
- Máy tính và Android device phải cùng mạng WiFi
- IP có thể thay đổi khi reconnect WiFi
- Xem file `NETWORK_SETUP.md` để biết chi tiết

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

1. **Không có Authentication**: API hiện tại không yêu cầu token/auth
2. **Error Handling**: Luôn kiểm tra `status` trong response (200 = success, "400" = error)
3. **Query Parameters**: Một số DELETE endpoint dùng query param là JSON array string: `?playlistUserId="[1,2,3]"`
4. **Image URLs**: Tất cả image fields là URL strings, cần load bằng Glide/Coil
5. **Base URL**: Nên dùng BuildConfig hoặc strings.xml để dễ switch dev/prod

---

## 📄 FILES THAM KHẢO

- **API_DOCUMENTATION_ANDROID.md**: Tài liệu chi tiết đầy đủ
- **android_api_config.json**: File config JSON để parse

---

**Sử dụng thông tin này để cấu hình Android client với Retrofit/OkHttp**

