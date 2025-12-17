# 📝 HƯỚNG DẪN THÊM DỮ LIỆU BÀI HÁT

## 🎯 Tổng quan

Để thêm dữ liệu bài hát vào database, bạn cần thêm theo thứ tự:
1. **Category** (Danh mục)
2. **Topic** (Chủ đề) - cần category_id
3. **Artist** (Nghệ sĩ)
4. **Album** - có thể có name_artist
5. **Playlist**
6. **Song** - cần album_id, playlist_id, topic_id
7. **Music_Video** - cần artist_id, topic_id
8. **LYRIC** - cần song_id

---

## 📋 CÁCH 1: SỬ DỤNG FILE SQL MẪU (Khuyến nghị)

### Bước 1: Chạy file sample_data.sql

File `sample_data.sql` đã chứa dữ liệu mẫu sẵn. Chạy trong MySQL:

```bash
mysql -u root -p musicapp_db < sample_data.sql
```

Hoặc trong MySQL command line:
```sql
source D:/LapTrinhDiDong/CuoiKy/Server/sample_data.sql;
```

**Lưu ý**: Thay đổi đường dẫn cho phù hợp với máy bạn.

### Bước 2: Kiểm tra dữ liệu

```sql
USE musicapp_db;

-- Kiểm tra số lượng
SELECT COUNT(*) AS total_songs FROM Song;
SELECT COUNT(*) AS total_albums FROM Album;
SELECT COUNT(*) AS total_playlists FROM Playlist;

-- Xem danh sách bài hát
SELECT * FROM Song LIMIT 10;

-- Xem danh sách album
SELECT * FROM Album;
```

---

## 📋 CÁCH 2: THÊM DỮ LIỆU THỦ CÔNG

### 1. Thêm Category

```sql
INSERT INTO Category (category_name, category_image) VALUES
('Pop', 'https://example.com/images/category/pop.jpg'),
('Rock', 'https://example.com/images/category/rock.jpg');
```

### 2. Thêm Topic

```sql
-- Lấy category_id từ bước 1 (ví dụ: category_id = 1)
INSERT INTO Topic (topic_name, topic_image, category_id) VALUES
('Top Hits', 'https://example.com/images/topic/tophits.jpg', 1),
('Chill Vibes', 'https://example.com/images/topic/chill.jpg', 1);
```

### 3. Thêm Artist

```sql
INSERT INTO Artist (artist_name, artist_image) VALUES
('Taylor Swift', 'https://example.com/images/artists/taylorswift.jpg'),
('Ed Sheeran', 'https://example.com/images/artists/edsheeran.jpg');
```

### 4. Thêm Album

```sql
INSERT INTO Album (album_name, album_image, name_artist, album_new) VALUES
('Midnights', 'https://example.com/images/albums/midnights.jpg', 'Taylor Swift', 1),
('÷ (Divide)', 'https://example.com/images/albums/divide.jpg', 'Ed Sheeran', 0);
```

**Lưu ý**: 
- `album_new = 1` → Album mới
- `album_new = 0` → Album cũ

### 5. Thêm Playlist

```sql
INSERT INTO Playlist (playlist_name, playlist_image, mood_today) VALUES
('Today\'s Top Hits', 'https://example.com/images/playlists/tophits.jpg', 1),
('Chill Hits', 'https://example.com/images/playlists/chill.jpg', 0);
```

**Lưu ý**: 
- `mood_today = 1` → Playlist tâm trạng hôm nay
- `mood_today = 0` → Playlist thường

### 6. Thêm Song (Quan trọng nhất)

```sql
-- Lấy các ID từ các bước trước:
-- album_id, playlist_id, topic_id

INSERT INTO Song (song_name, song_image, song_url, album_id, playlist_id, topic_id, download) VALUES
('Anti-Hero', 
 'https://example.com/images/songs/antihero.jpg', 
 'https://example.com/audio/antihero.mp3', 
 1,  -- album_id (Midnights)
 1,  -- playlist_id (Today's Top Hits)
 1,  -- topic_id (Top Hits)
 'https://example.com/download/antihero.mp3');
```

**Các trường bắt buộc**:
- `song_name`: Tên bài hát
- `song_image`: URL ảnh bài hát
- `song_url`: URL file audio (MP3, etc.)
- `album_id`: ID của album (phải tồn tại trong bảng Album)
- `playlist_id`: ID của playlist (phải tồn tại trong bảng Playlist)
- `topic_id`: ID của topic (phải tồn tại trong bảng Topic)
- `download`: URL download (có thể NULL)

### 7. Thêm Music Video

```sql
-- Cần artist_id và topic_id
INSERT INTO Music_Video (music_video_name, music_video_image, music_video_time, music_video_proposal_new, artist_id, topic_id) VALUES
('Anti-Hero MV', 
 'https://example.com/images/mv/antihero.jpg', 
 '3:20', 
 1,  -- music_video_proposal_new (1 = mới, 0 = cũ)
 1,  -- artist_id (Taylor Swift)
 1); -- topic_id
```

### 8. Thêm Lời bài hát (LYRIC)

```sql
-- Cần song_id
INSERT INTO LYRIC (song_id, lyric_text, startMs) VALUES
(1, 'I have this thing where I get older but just never wiser', 0),
(1, 'Midnights become my afternoons', 5000),
(1, 'When my depression works the graveyard shift', 10000);
```

**Lưu ý**: 
- `startMs`: Thời gian bắt đầu câu lyric (milliseconds)
- Có thể thêm nhiều dòng lyric cho một bài hát

---

## 🔍 KIỂM TRA DỮ LIỆU

### Xem tất cả bài hát

```sql
SELECT s.song_id, s.song_name, a.album_name, a.name_artist 
FROM Song s 
INNER JOIN Album a ON s.album_id = a.album_id;
```

### Xem bài hát theo album

```sql
SELECT * FROM Song WHERE album_id = 1;
```

### Xem bài hát theo playlist

```sql
SELECT * FROM Song WHERE playlist_id = 1;
```

### Xem bài hát theo topic

```sql
SELECT * FROM Song WHERE topic_id = 1;
```

---

## 📝 LƯU Ý QUAN TRỌNG

### 1. Thứ tự thêm dữ liệu
Phải thêm theo thứ tự:
- Category → Topic
- Artist (độc lập)
- Album (độc lập)
- Playlist (độc lập)
- Song (cần album_id, playlist_id, topic_id)
- Music_Video (cần artist_id, topic_id)
- LYRIC (cần song_id)

### 2. Foreign Key Constraints
- Không thể thêm Song nếu album_id, playlist_id, topic_id không tồn tại
- Không thể thêm Music_Video nếu artist_id, topic_id không tồn tại
- Không thể thêm LYRIC nếu song_id không tồn tại

### 3. URL Images và Audio
- Tất cả URL trong file mẫu là ví dụ
- Bạn cần thay thế bằng URL thực tế của:
  - Ảnh bài hát, album, artist, playlist
  - File audio (MP3, M4A, etc.)
  - File video (MP4, etc.)

### 4. Format Audio/Video URLs
Có thể sử dụng:
- URL trực tiếp: `https://example.com/audio/song.mp3`
- CDN: `https://cdn.example.com/audio/song.mp3`
- Local server: `http://YOUR_IP:3000/audio/song.mp3` (nếu host file trên server)

---

## 🛠️ CÁCH 3: THÊM DỮ LIỆU QUA API (Nếu có)

Hiện tại backend chưa có API để thêm dữ liệu. Bạn có thể:
1. Sử dụng SQL trực tiếp (Cách 1 và 2)
2. Tạo API endpoint mới để thêm dữ liệu (cần phát triển thêm)

---

## 📊 VÍ DỤ THÊM DỮ LIỆU THỰC TẾ

### Ví dụ: Thêm một bài hát mới

```sql
-- Bước 1: Kiểm tra các ID cần thiết
SELECT album_id, album_name FROM Album;
SELECT playlist_id, playlist_name FROM Playlist;
SELECT topic_id, topic_name FROM Topic;

-- Giả sử:
-- album_id = 1 (Midnights)
-- playlist_id = 1 (Today's Top Hits)
-- topic_id = 1 (Top Hits)

-- Bước 2: Thêm bài hát
INSERT INTO Song (song_name, song_image, song_url, album_id, playlist_id, topic_id, download) VALUES
('New Song Name', 
 'https://your-cdn.com/images/songs/newsong.jpg', 
 'https://your-cdn.com/audio/newsong.mp3', 
 1, 1, 1,
 'https://your-cdn.com/download/newsong.mp3');

-- Bước 3: Kiểm tra
SELECT * FROM Song WHERE song_name = 'New Song Name';
```

---

## 🐛 XỬ LÝ LỖI

### Lỗi: "Cannot add or update a child row: a foreign key constraint fails"
**Nguyên nhân**: Đang thêm Song/Video/Lyric với ID không tồn tại
**Giải pháp**: 
- Kiểm tra album_id, playlist_id, topic_id, artist_id, song_id có tồn tại không
- Thêm các bảng cha trước (Category, Topic, Artist, Album, Playlist)

### Lỗi: "Duplicate entry"
**Nguyên nhân**: Đang thêm dữ liệu trùng lặp
**Giải pháp**: 
- Kiểm tra dữ liệu đã tồn tại chưa
- Sử dụng `INSERT IGNORE` hoặc `ON DUPLICATE KEY UPDATE`

---

## ✅ CHECKLIST THÊM DỮ LIỆU

- [ ] Đã thêm Category
- [ ] Đã thêm Topic (với category_id đúng)
- [ ] Đã thêm Artist
- [ ] Đã thêm Album
- [ ] Đã thêm Playlist
- [ ] Đã thêm Song (với album_id, playlist_id, topic_id đúng)
- [ ] Đã thêm Music_Video (nếu cần)
- [ ] Đã thêm LYRIC (nếu cần)
- [ ] Đã kiểm tra dữ liệu bằng SELECT queries
- [ ] Đã test API endpoints để xem dữ liệu

---

**Chúc bạn thêm dữ liệu thành công! 🎵**

