# 📁 Thư mục Public - Tài nguyên tĩnh cho Music App

Thư mục này chứa tất cả các file tĩnh (static files) được sử dụng bởi Music App, bao gồm audio, video và hình ảnh.

## 📂 Cấu trúc thư mục

```
public/
├── audio/              # File âm thanh (.mp3, .m4a, .wav, etc.)
├── video/              # File video (.mp4, .mov, etc.)
└── images/             # Hình ảnh
    ├── category/       # Hình ảnh danh mục
    ├── topic/          # Hình ảnh chủ đề
    ├── artists/        # Hình ảnh nghệ sĩ
    ├── albums/         # Hình ảnh album
    ├── songs/          # Hình ảnh bài hát
    ├── playlists/      # Hình ảnh playlist
    └── mv/             # Hình ảnh thumbnail music video
```

## 🔗 Cách truy cập file

Tất cả các file trong thư mục `public/` có thể được truy cập qua URL với prefix `/public/`.

### Ví dụ:
- File: `public/audio/antihero.mp3`
- URL: `http://localhost:3000/public/audio/antihero.mp3`
- Hoặc trên network: `http://YOUR_IP:3000/public/audio/antihero.mp3`

### Các loại file:

#### Audio Files
- Đường dẫn trong database: `/public/audio/song-name.mp3`
- URL đầy đủ: `http://localhost:3000/public/audio/song-name.mp3`

#### Image Files
- Đường dẫn trong database: `/public/images/category/pop.jpg`
- URL đầy đủ: `http://localhost:3000/public/images/category/pop.jpg`

#### Video Files
- Đường dẫn trong database: `/public/video/video-name.mp4`
- URL đầy đủ: `http://localhost:3000/public/video/video-name.mp4`

## 📝 Lưu ý khi thêm file

### 1. Đặt tên file
- Sử dụng tên file rõ ràng, dễ hiểu
- Tránh khoảng trắng, sử dụng dấu gạch ngang (`-`) hoặc gạch dưới (`_`)
- Ví dụ: `anti-hero.mp3`, `taylor-swift.jpg`

###2. Định dạng file được hỗ trợ

#### Audio:
- `.mp3` (khuyến nghị)
- `.m4a`
- `.wav`
- `.ogg`

#### Image:
- `.jpg` / `.jpeg` (khuyến nghị)
- `.png`
- `.webp`
- `.gif`

#### Video:
- `.mp4` (khuyến nghị)
- `.mov`
- `.webm`

### 3. Kích thước file khuyến nghị

#### Audio:
- Chất lượng: 128-320 kbps
- Độ dài: Tùy theo bài hát

#### Image:
- Category/Topic: 500x500px hoặc 1000x1000px
- Artist: 800x800px hoặc 1000x1000px
- Album: 1000x1000px
- Song thumbnail: 500x500px
- Playlist: 1000x1000px
- MV thumbnail: 1280x720px (16:9)

#### Video:
- Độ phân giải: 720p (1280x720) hoặc 1080p (1920x1080)
- Format: MP4 với H.264 codec

## 🔄 Cập nhật database

Sau khi thêm file vào thư mục `public/`, bạn cần cập nhật database với đường dẫn tương đối:

```sql
-- Ví dụ: Thêm bài hát mới
INSERT INTO Song (song_name, song_image, song_url, album_id, playlist_id, topic_id, download) 
VALUES 
('Tên bài hát', '/public/images/songs/song-image.jpg', '/public/audio/song.mp3', 1, 1, 1, '/public/audio/song.mp3');
```

## 🌐 Sử dụng với Android Client

Khi Android client nhận được đường dẫn từ API, nó sẽ tự động thêm base URL:

```kotlin
// Ví dụ trong Android
val baseUrl = "http://192.168.1.100:3000" // IP của server
val songUrl = baseUrl + song.song_url // /public/audio/song.mp3
// Kết quả: http://192.168.1.100:3000/public/audio/song.mp3
```

## ⚠️ Lưu ý quan trọng

1. **Đảm bảo server đang chạy**: File chỉ có thể truy cập được khi Express server đang chạy
2. **Cùng mạng WiFi**: Android device phải cùng mạng WiFi với server
3. **Quyền truy cập**: Đảm bảo Express đã được cấu hình để serve static files (đã được cấu hình trong `index.js`)
4. **URL đầy đủ vs tương đối**: 
   - Database lưu đường dẫn tương đối: `/public/audio/song.mp3`
   - Client tự động thêm base URL khi sử dụng
   - Hoặc có thể lưu URL đầy đủ nếu cần (ví dụ: URL từ YouTube, Zing MP3)

## 🛠️ Troubleshooting

### File không load được?
1. Kiểm tra file có tồn tại trong thư mục `public/` không
2. Kiểm tra đường dẫn trong database có đúng không (phải bắt đầu bằng `/public/`)
3. Kiểm tra server có đang chạy không
4. Kiểm tra firewall có chặn port 3000 không

### Android không thể truy cập?
1. Đảm bảo Android device và server cùng mạng WiFi
2. Sử dụng IP của server thay vì `localhost`
3. Kiểm tra URL trong API response

## 📚 Tài liệu tham khảo

- Xem file `sample_data.sql` để biết cách thêm dữ liệu mẫu
- Xem file `index.js` để biết cách server serve static files
- Xem file `utils/urlHelper.js` để biết cách convert URL (nếu cần)

