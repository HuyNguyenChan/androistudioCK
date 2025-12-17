# 📱 TÀI LIỆU API CHO ANDROID CLIENT

## 🔧 CẤU HÌNH CƠ BẢN

### Base URL
```
http://localhost:3000/api
```
**Lưu ý**: Khi deploy lên server thực tế, thay `localhost:3000` bằng địa chỉ IP/domain của server.

### Production URL (nếu có)
```
https://your-domain.com/api
```

### Headers
Tất cả requests sử dụng:
```
Content-Type: application/json
Accept: application/json
```

### Response Format
Tất cả responses đều có format:
```json
{
  "status": 200,  // hoặc "400" nếu lỗi
  "data": {...}   // hoặc "message": "error message" nếu lỗi
}
```

---

## 📋 DANH SÁCH API ENDPOINTS

### 1. USER APIs

#### 1.1. Tạo người dùng mới
- **Method**: `POST`
- **URL**: `/api/user`
- **Request Body**:
```json
{
  "userId": "user123"
}
```
- **Response Success** (200):
```json
{
  "status": 200,
  "user": {
    "insertId": 1,
    "affectedRows": 1
  }
}
```
- **Response Error** (400):
```json
{
  "status": "400",
  "error": "Error message"
}
```

---

### 2. SONG APIs

#### 2.1. Lấy danh sách tất cả bài hát
- **Method**: `GET`
- **URL**: `/api/songs`
- **Response**:
```json
{
  "status": 200,
  "songs": [
    {
      "song_id": 1,
      "song_name": "Tên bài hát",
      "song_image": "https://...",
      "song_url": "https://...",
      "name_artist": "Tên nghệ sĩ"
    }
  ]
}
```

#### 2.2. Lấy bài hát theo Playlist ID
- **Method**: `GET`
- **URL**: `/api/songs/playlist/:playlistId`
- **Path Parameters**: `playlistId` (int)
- **Response**:
```json
{
  "status": 200,
  "songs": [
    {
      "song_id": 1,
      "song_name": "Tên bài hát",
      "song_image": "https://...",
      "song_url": "https://...",
      "name_artist": "Tên nghệ sĩ",
      "download": "https://..."
    }
  ]
}
```

#### 2.3. Lấy bài hát theo Topic ID
- **Method**: `GET`
- **URL**: `/api/songs/topic/:topicId`
- **Path Parameters**: `topicId` (int)

#### 2.4. Lấy bài hát theo Album ID
- **Method**: `GET`
- **URL**: `/api/songs/album/:albumId`
- **Path Parameters**: `albumId` (int)

#### 2.5. Lấy danh sách bài hát yêu thích của user
- **Method**: `GET`
- **URL**: `/api/songs/love/:userId`
- **Path Parameters**: `userId` (string)
- **Response**:
```json
{
  "status": 200,
  "songs": [
    {
      "song_love_id": 1,
      "song_id": 1,
      "song_name": "Tên bài hát",
      "song_image": "https://...",
      "song_url": "https://...",
      "name_artist": "Tên nghệ sĩ"
    }
  ]
}
```

#### 2.6. Thêm bài hát vào yêu thích
- **Method**: `POST`
- **URL**: `/api/song/love`
- **Request Body**:
```json
{
  "userId": "user123",
  "songId": 1
}
```

#### 2.7. Xóa bài hát khỏi yêu thích
- **Method**: `DELETE`
- **URL**: `/api/song/love/:songLoveId`
- **Path Parameters**: `songLoveId` (int)

---

### 3. PLAYLIST APIs

#### 3.1. Lấy danh sách tất cả playlist
- **Method**: `GET`
- **URL**: `/api/playlists`
- **Response**:
```json
{
  "status": 200,
  "playlists": [
    {
      "playlist_id": 1,
      "playlist_name": "Tên playlist",
      "playlist_image": "https://...",
      "name_artist": "Nghệ sĩ 1, Nghệ sĩ 2"
    }
  ]
}
```

#### 3.2. Lấy playlist theo tâm trạng hôm nay
- **Method**: `GET`
- **URL**: `/api/playlists/mood/today`

#### 3.3. Lấy playlist của user
- **Method**: `GET`
- **URL**: `/api/playlists/:userId`
- **Path Parameters**: `userId` (string)
- **Response**:
```json
{
  "status": 200,
  "playlists": [
    {
      "playlist_user_id": 1,
      "playlist_user_name": "My Playlist",
      "song_count": 5,
      "song_image": "https://...",
      "name_artist": "Artist 1, Artist 2"
    }
  ]
}
```

#### 3.4. Lấy playlist yêu thích của user
- **Method**: `GET`
- **URL**: `/api/playlists/love/:userId`
- **Path Parameters**: `userId` (string)

#### 3.5. Lấy danh sách bài hát trong playlist của user
- **Method**: `GET`
- **URL**: `/api/playlists/songs/:playlistUserId`
- **Path Parameters**: `playlistUserId` (int)

#### 3.6. Tạo playlist mới cho user
- **Method**: `POST`
- **URL**: `/api/playlist/user`
- **Request Body**:
```json
{
  "namePlaylist": "Tên playlist",
  "userId": "user123"
}
```

#### 3.7. Thêm bài hát vào playlist của user
- **Method**: `POST`
- **URL**: `/api/playlist/user/song`
- **Request Body**:
```json
{
  "playlistUserId": 1,
  "songId": 1
}
```
- **Response Success** (200):
```json
{
  "status": 200
}
```
- **Response Error** (409 - đã tồn tại):
```json
{
  "status": 409
}
```

#### 3.8. Thêm playlist vào yêu thích
- **Method**: `POST`
- **URL**: `/api/playlist/user/love`
- **Request Body**:
```json
{
  "userId": "user123",
  "playlistId": 1
}
```

#### 3.9. Xóa playlist của user
- **Method**: `DELETE`
- **URL**: `/api/playlistsUser?playlistUserId=[1,2,3]`
- **Query Parameters**: `playlistUserId` (JSON array string, ví dụ: `"[1,2,3]"`)

#### 3.10. Xóa playlist khỏi yêu thích
- **Method**: `DELETE`
- **URL**: `/api/playlistsLove?playlistLoveId=[1,2,3]`
- **Query Parameters**: `playlistLoveId` (JSON array string)

---

### 4. ALBUM APIs

#### 4.1. Lấy danh sách album mới
- **Method**: `GET`
- **URL**: `/api/albums/new`
- **Response**:
```json
{
  "status": 200,
  "albums": [
    {
      "album_id": 1,
      "album_name": "Tên album",
      "album_image": "https://...",
      "name_artist": "Tên nghệ sĩ"
    }
  ]
}
```

#### 4.2. Lấy danh sách album yêu thích
- **Method**: `GET`
- **URL**: `/api/albums/love`

---

### 5. SEARCH APIs

#### 5.1. Tìm kiếm theo từ khóa
- **Method**: `GET`
- **URL**: `/api/search/:keyword`
- **Path Parameters**: `keyword` (string)
- **Response**:
```json
{
  "status": 200,
  "search": {
    "songs": [
      {
        "song_id": 1,
        "song_name": "Tên bài hát",
        "song_image": "https://...",
        "song_url": "https://...",
        "name_artist": "Tên nghệ sĩ",
        "song_count": null,
        "artist_id": null
      }
    ],
    "playlists": [
      {
        "playlist_id": 1,
        "playlist_name": "Tên playlist",
        "playlist_image": "https://...",
        "url": null,
        "name_artist": "Nghệ sĩ",
        "song_count": 10,
        "artist_id": null
      }
    ],
    "music_videos": [
      {
        "music_video_id": 1,
        "music_video_name": "Tên video",
        "artist_image": "https://...",
        "music_video_time": "3:45",
        "artist_name": "Tên nghệ sĩ",
        "music_video_image": "https://...",
        "artist_id": 1
      }
    ],
    "albums": [
      {
        "album_id": 1,
        "album_name": "Tên album",
        "album_image": "https://...",
        "url": null,
        "name_artist": "Tên nghệ sĩ",
        "song_count": 12,
        "artist_id": null
      }
    ]
  }
}
```

#### 5.2. Lấy tất cả tên để gợi ý tìm kiếm
- **Method**: `GET`
- **URL**: `/api/search/all/name`
- **Response**:
```json
{
  "status": 200,
  "search": [
    {
      "name": "Tên bài hát/playlist/album/video"
    }
  ]
}
```

---

### 6. MUSIC VIDEO APIs

#### 6.1. Lấy danh sách video âm nhạc
- **Method**: `GET`
- **URL**: `/api/musics/video`
- **Response**:
```json
{
  "status": 200,
  "music_videos": [
    {
      "music_video_id": 1,
      "music_video_name": "Tên video",
      "artist_id": 1,
      "artist_name": "Tên nghệ sĩ",
      "artist_image": "https://...",
      "music_video_image": "https://...",
      "music_video_time": "3:45",
      "music_video_proposal_new": 1,
      "topic_id": 1
    }
  ]
}
```

#### 6.2. Lấy danh sách video (loại trừ một video)
- **Method**: `GET`
- **URL**: `/api/musics/video/:musicVideoId`
- **Path Parameters**: `musicVideoId` (int)

---

### 7. LYRIC APIs

#### 7.1. Lấy lời bài hát theo Song ID
- **Method**: `GET`
- **URL**: `/api/lyrics/:songId`
- **Path Parameters**: `songId` (int)
- **Response**:
```json
{
  "status": 200,
  "lyrics": [
    {
      "lyric_text": "Lời bài hát...",
      "startMs": 0
    },
    {
      "lyric_text": "Câu tiếp theo...",
      "startMs": 5000
    }
  ]
}
```

---

### 8. TOPIC APIs

#### 8.1. Lấy danh sách tất cả topic
- **Method**: `GET`
- **URL**: `/api/topics`
- **Response**:
```json
{
  "status": 200,
  "topics": [
    {
      "topic_id": 1,
      "topic_name": "Tên topic",
      "topic_image": "https://...",
      "category_id": 1
    }
  ]
}
```

#### 8.2. Lấy topic theo Category ID
- **Method**: `GET`
- **URL**: `/api/topics/categories/:categoryId`
- **Path Parameters**: `categoryId` (int)

---

### 9. CATEGORY APIs

#### 9.1. Lấy danh sách tất cả category
- **Method**: `GET`
- **URL**: `/api/categories`
- **Response**:
```json
{
  "status": 200,
  "categories": [
    {
      "category_id": 1,
      "category_name": "Tên danh mục",
      "category_image": "https://..."
    }
  ]
}
```

---

### 10. FOLLOW APIs

#### 10.1. Theo dõi nghệ sĩ
- **Method**: `POST`
- **URL**: `/api/follow`
- **Request Body**:
```json
{
  "userId": "user123",
  "artistId": 1
}
```

#### 10.2. Kiểm tra đã theo dõi chưa
- **Method**: `GET`
- **URL**: `/api/followed/:userId/:artistId`
- **Path Parameters**: 
  - `userId` (string)
  - `artistId` (int)
- **Response**:
```json
{
  "status": 200,
  "follows": [
    {
      "isFollow": 1  // 1 = đã follow, 0 = chưa follow
    }
  ]
}
```

#### 10.3. Lấy số lượng nghệ sĩ đã theo dõi
- **Method**: `GET`
- **URL**: `/api/follow/quantity/:userId`
- **Path Parameters**: `userId` (string)

#### 10.4. Lấy danh sách nghệ sĩ đã theo dõi
- **Method**: `GET`
- **URL**: `/api/follows/:userId`
- **Path Parameters**: `userId` (string)
- **Response**:
```json
{
  "status": 200,
  "follows": [
    {
      "follow_id": 1,
      "artist_id": 1,
      "artist_name": "Tên nghệ sĩ",
      "artist_image": "https://...",
      "follower_count": 100
    }
  ]
}
```

#### 10.5. Bỏ theo dõi nghệ sĩ
- **Method**: `DELETE`
- **URL**: `/api/follow/:userId/:artistId`
- **Path Parameters**: 
  - `userId` (string)
  - `artistId` (int)

---

### 11. SONG RANK APIs

#### 11.1. Lấy bảng xếp hạng bài hát
- **Method**: `GET`
- **URL**: `/api/songs/rank/listen`

---

### 12. SONG AGAIN APIs

#### 12.1. Lấy danh sách bài hát nghe lại
- **Method**: `GET`
- **URL**: `/api/songs/Again/:id`
- **Path Parameters**: `id` (string - userId)

#### 12.2. Thêm bài hát vào lịch sử nghe
- **Method**: `POST`
- **URL**: `/api/song/again`
- **Request Body**:
```json
{
  "userId": "user123",
  "songId": 1
}
```

---

### 13. DEEPLINK API

#### 13.1. Lấy deeplink streaming
- **Method**: `GET`
- **URL**: `/api/getDeeplink`
- **Response**:
```json
{
  "deeplink": "https://6ztfh0rs-3000.asse.devtunnels.ms/live/stream/fb"
}
```

---

## 🔗 ANDROID APP LINKS CONFIGURATION

### Asset Links
Server cung cấp file asset links tại:
```
/.well-known/assetlinks.json
```

**Response**:
```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.example.musicapp",
    "sha256_cert_fingerprints": [
      "8D:D1:06:52:C0:41:BF:4B:77:7E:C5:4B:F6:5E:34:F2:22:82:37:E4:C8:08:5F:3B:88:29:B7:27:D0:84:6F:77"
    ]
  }
}]
```

**Cấu hình trong AndroidManifest.xml**:
```xml
<activity android:name=".MainActivity">
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data
            android:scheme="https"
            android:host="your-domain.com" />
    </intent-filter>
</activity>
```

---

## 📦 CẤU TRÚC DỮ LIỆU

### Song Object
```json
{
  "song_id": 1,
  "song_name": "string",
  "song_image": "string (URL)",
  "song_url": "string (URL)",
  "name_artist": "string",
  "download": "string (URL, optional)"
}
```

### Playlist Object
```json
{
  "playlist_id": 1,
  "playlist_name": "string",
  "playlist_image": "string (URL)",
  "name_artist": "string"
}
```

### Album Object
```json
{
  "album_id": 1,
  "album_name": "string",
  "album_image": "string (URL)",
  "name_artist": "string"
}
```

### Music Video Object
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

### Artist Object
```json
{
  "artist_id": 1,
  "artist_name": "string",
  "artist_image": "string (URL)"
}
```

---

## ⚠️ ERROR HANDLING

### Status Codes
- **200**: Success
- **400**: Bad Request / Error
- **409**: Conflict (đã tồn tại)

### Error Response Format
```json
{
  "status": "400",
  "error": "Error message",
  // hoặc
  "message": "Error message"
}
```

---

## 🔐 AUTHENTICATION

**Hiện tại**: API không yêu cầu authentication token. Tất cả requests đều public.

**Lưu ý**: Nếu cần thêm authentication sau này, sẽ cần:
- Thêm header: `Authorization: Bearer <token>`
- Hoặc sử dụng API key trong header

---

## 📝 NOTES CHO ANDROID DEVELOPER

1. **Base URL**: Sử dụng biến trong `BuildConfig` hoặc `strings.xml` để dễ thay đổi giữa dev/prod
2. **Retrofit/OkHttp**: Khuyến nghị sử dụng Retrofit cho API calls
3. **Image Loading**: Sử dụng Glide hoặc Coil để load images từ URLs
4. **Error Handling**: Luôn kiểm tra `status` trong response trước khi xử lý data
5. **Network Security**: Thêm network security config nếu sử dụng HTTP (không phải HTTPS) trong development

---

## 🚀 DEPLOYMENT NOTES

Khi deploy lên server thực tế:
1. Thay đổi Base URL trong Android app
2. Cập nhật Android App Links host trong `assetlinks.json`
3. Cập nhật SHA256 fingerprint trong `assetlinks.json` với fingerprint của keystore production
4. Đảm bảo server hỗ trợ HTTPS cho App Links

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**Contact**: [Your contact info]

