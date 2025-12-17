# 📱 HƯỚNG DẪN CẬP NHẬT CLIENT - Static Files System

## 🔄 TÓM TẮT THAY ĐỔI

Server đã được cập nhật để sử dụng **static files system** thay vì URL đầy đủ từ bên ngoài. Tất cả audio, video và images được lưu trữ trong thư mục `public/` và được serve trực tiếp từ server.

---

## 📋 THAY ĐỔI CHÍNH

### 1. **Đường dẫn trong Database**

**Trước đây:**
```json
{
  "song_url": "https://example.com/audio/song.mp3",
  "song_image": "https://example.com/images/song.jpg"
}
```

**Bây giờ:**
```json
{
  "song_url": "/public/audio/shape_of_you.mp3",
  "song_image": "/public/images/songs/shape.jpg"
}
```

### 2. **Cấu trúc thư mục trên Server**

```
public/
├── audio/              # File âm thanh (.mp3)
├── video/              # File video (.mp4)
└── images/
    ├── category/       # Hình ảnh danh mục
    ├── topic/          # Hình ảnh chủ đề
    ├── artists/        # Hình ảnh nghệ sĩ
    ├── albums/         # Hình ảnh album
    ├── songs/          # Hình ảnh bài hát
    ├── playlists/      # Hình ảnh playlist
    └── mv/             # Thumbnail music video
```

---

## 🔧 CẬP NHẬT CODE CLIENT

### **Android (Kotlin/Java)**

#### 1. **Tạo Base URL Helper**

```kotlin
object ApiConfig {
    // Thay đổi IP này thành IP của server khi test
    const val BASE_URL = "http://192.168.1.100:3000"
    
    // Helper function để convert đường dẫn tương đối thành URL đầy đủ
    fun getFullUrl(path: String?): String? {
        if (path.isNullOrEmpty()) return null
        
        // Nếu đã là URL đầy đủ (http:// hoặc https://), trả về nguyên
        if (path.startsWith("http://") || path.startsWith("https://")) {
            return path
        }
        
        // Nếu là đường dẫn tương đối, thêm base URL
        return if (path.startsWith("/")) {
            "$BASE_URL$path"
        } else {
            "$BASE_URL/$path"
        }
    }
}
```

#### 2. **Cập nhật Model/Data Class**

```kotlin
data class Song(
    val song_id: Int,
    val song_name: String,
    val song_image: String?,
    val song_url: String?,
    val name_artist: String?,
    val download: String?
) {
    // Getter methods để tự động convert URL
    fun getFullImageUrl(): String? = ApiConfig.getFullUrl(song_image)
    fun getFullAudioUrl(): String? = ApiConfig.getFullUrl(song_url)
    fun getFullDownloadUrl(): String? = ApiConfig.getFullUrl(download)
}
```

#### 3. **Sử dụng trong Code**

**Trước đây:**
```kotlin
// Load image
Glide.with(context)
    .load(song.song_image)  // Đã là URL đầy đủ
    .into(imageView)

// Play audio
mediaPlayer.setDataSource(song.song_url)  // Đã là URL đầy đủ
```

**Bây giờ:**
```kotlin
// Load image
Glide.with(context)
    .load(song.getFullImageUrl())  // Tự động convert
    .into(imageView)

// Hoặc
Glide.with(context)
    .load(ApiConfig.getFullUrl(song.song_image))  // Convert trực tiếp
    .into(imageView)

// Play audio
mediaPlayer.setDataSource(song.getFullAudioUrl())
// Hoặc
mediaPlayer.setDataSource(ApiConfig.getFullUrl(song.song_url))
```

---

### **iOS (Swift)**

#### 1. **Tạo Base URL Helper**

```swift
struct ApiConfig {
    static let baseURL = "http://192.168.1.100:3000"
    
    static func getFullURL(_ path: String?) -> String? {
        guard let path = path, !path.isEmpty else { return nil }
        
        // Nếu đã là URL đầy đủ
        if path.hasPrefix("http://") || path.hasPrefix("https://") {
            return path
        }
        
        // Convert đường dẫn tương đối
        if path.hasPrefix("/") {
            return baseURL + path
        } else {
            return baseURL + "/" + path
        }
    }
}
```

#### 2. **Sử dụng**

```swift
// Load image
let imageURL = ApiConfig.getFullURL(song.song_image)
imageView.loadImage(from: imageURL)

// Play audio
let audioURL = ApiConfig.getFullURL(song.song_url)
player.load(url: audioURL)
```

---

### **Web (JavaScript/React)**

#### 1. **Tạo Helper Function**

```javascript
const BASE_URL = 'http://localhost:3000'; // Hoặc IP của server

function getFullUrl(path) {
    if (!path) return null;
    
    // Nếu đã là URL đầy đủ
    if (path.startsWith('http://') || path.startsWith('https://')) {
        return path;
    }
    
    // Convert đường dẫn tương đối
    return path.startsWith('/') 
        ? `${BASE_URL}${path}` 
        : `${BASE_URL}/${path}`;
}
```

#### 2. **Sử dụng**

```javascript
// Load image
<img src={getFullUrl(song.song_image)} alt={song.song_name} />

// Play audio
<audio src={getFullUrl(song.song_url)} controls />
```

---

## 📝 CÁC TRƯỜNG CẦN CẬP NHẬT

Tất cả các trường chứa đường dẫn file trong API response cần được xử lý:

### **Song Object**
- `song_image` → `/public/images/songs/...`
- `song_url` → `/public/audio/...`
- `download` → `/public/audio/...`

### **Album Object**
- `album_image` → `/public/images/albums/...`

### **Playlist Object**
- `playlist_image` → `/public/images/playlists/...`

### **Artist Object**
- `artist_image` → `/public/images/artists/...`

### **Category Object**
- `category_image` → `/public/images/category/...`

### **Topic Object**
- `topic_image` → `/public/images/topic/...`

### **Music Video Object**
- `music_video_image` → `/public/images/mv/...`

---

## ⚠️ LƯU Ý QUAN TRỌNG

### 1. **Hỗ trợ cả URL đầy đủ và đường dẫn tương đối**

Một số trường vẫn có thể chứa URL đầy đủ (ví dụ: YouTube URL, URL từ zingmp3.vn). Code client cần xử lý cả hai trường hợp:

```kotlin
fun getFullUrl(path: String?): String? {
    if (path.isNullOrEmpty()) return null
    
    // Nếu đã là URL đầy đủ, trả về nguyên
    if (path.startsWith("http://") || path.startsWith("https://")) {
        return path
    }
    
    // Nếu là đường dẫn tương đối, thêm base URL
    return "$BASE_URL$path"
}
```

### 2. **Base URL động**

Base URL nên được cấu hình động để dễ chuyển đổi giữa môi trường dev/prod:

```kotlin
object ApiConfig {
    private const val DEV_BASE_URL = "http://192.168.1.100:3000"
    private const val PROD_BASE_URL = "https://your-domain.com"
    
    val BASE_URL = if (BuildConfig.DEBUG) DEV_BASE_URL else PROD_BASE_URL
}
```

### 3. **Network Security (Android)**

Nếu sử dụng HTTP (không phải HTTPS), cần cấu hình Network Security Config:

**res/xml/network_security_config.xml:**
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">192.168.1.100</domain>
        <domain includeSubdomains="true">localhost</domain>
    </domain-config>
</network-security-config>
```

**AndroidManifest.xml:**
```xml
<application
    android:networkSecurityConfig="@xml/network_security_config"
    ...>
```

---

## 🧪 TESTING

### 1. **Kiểm tra API Response**

```bash
# Test API
curl http://localhost:3000/api/songs

# Response sẽ có dạng:
{
  "status": 200,
  "songs": [
    {
      "song_id": 1,
      "song_name": "Shape of You",
      "song_image": "/public/images/songs/shape.jpg",
      "song_url": "/public/audio/shape_of_you.mp3",
      ...
    }
  ]
}
```

### 2. **Kiểm tra Static Files**

```bash
# Test truy cập file trực tiếp
curl http://localhost:3000/public/audio/shape_of_you.mp3
curl http://localhost:3000/public/images/songs/shape.jpg
```

### 3. **Test trên Android Device**

1. Đảm bảo Android device và server cùng mạng WiFi
2. Lấy IP của server (hiển thị khi start server)
3. Cập nhật `BASE_URL` trong code Android
4. Test load image và play audio

---

## 📚 TÀI LIỆU THAM KHẢO

- Xem `public/README.md` để biết cấu trúc thư mục chi tiết
- Xem `sample_data.sql` để biết cấu trúc dữ liệu mẫu
- Xem `index.js` để biết cách server serve static files

---

## ✅ CHECKLIST CẬP NHẬT

- [ ] Tạo helper function `getFullUrl()` trong client
- [ ] Cập nhật tất cả nơi load image (Glide, SDWebImage, etc.)
- [ ] Cập nhật tất cả nơi load audio/video
- [ ] Cấu hình Base URL động (dev/prod)
- [ ] Cấu hình Network Security (Android - nếu dùng HTTP)
- [ ] Test load image từ server
- [ ] Test play audio từ server
- [ ] Test trên thiết bị thật (không chỉ emulator)

---

**Ngày cập nhật:** 2025-11-29  
**Phiên bản:** 1.0

