-- ============================================
-- SCRIPT THÊM DỮ LIỆU MẪU CHO MUSIC APP
-- CHỈ CHO BÀI HÁT "SHAPE OF YOU" - ĐỂ TEST NHANH
-- ============================================

USE musicapp_db;

-- ============================================
-- XÓA DỮ LIỆU CŨ (Nếu có)
-- ============================================
-- Lưu ý: Xóa theo thứ tự ngược lại để tránh lỗi Foreign Key Constraint

-- Xóa dữ liệu từ các bảng phụ thuộc trước
DELETE FROM album_love;
DELETE FROM LYRIC;
DELETE FROM Music_Video;
DELETE FROM Song;
DELETE FROM Playlist;
DELETE FROM Album;
DELETE FROM Topic;
DELETE FROM Artist;
DELETE FROM Category;

-- Reset AUTO_INCREMENT (nếu có)
ALTER TABLE album_love AUTO_INCREMENT = 1;
ALTER TABLE LYRIC AUTO_INCREMENT = 1;
ALTER TABLE Music_Video AUTO_INCREMENT = 1;
ALTER TABLE Song AUTO_INCREMENT = 1;
ALTER TABLE Playlist AUTO_INCREMENT = 1;
ALTER TABLE Album AUTO_INCREMENT = 1;
ALTER TABLE Topic AUTO_INCREMENT = 1;
ALTER TABLE Artist AUTO_INCREMENT = 1;
ALTER TABLE Category AUTO_INCREMENT = 1;

-- ============================================
-- 1. THÊM DỮ LIỆU CATEGORY (Danh mục)
-- ============================================
-- Chỉ thêm 1 category: Pop

INSERT INTO Category (category_name, category_image) VALUES
('Pop', '/public/images/category/pop.jpg');

-- ============================================
-- 2. THÊM DỮ LIỆU TOPIC (Chủ đề)
-- ============================================
-- Chỉ thêm 1 topic: Top Hits (thuộc category Pop - ID = 1)

INSERT INTO Topic (topic_name, topic_image, category_id) VALUES
('Top Hits', '/public/images/topic/tophits.jpg', 1);

-- ============================================
-- 3. THÊM DỮ LIỆU ARTIST (Nghệ sĩ)
-- ============================================
-- Chỉ thêm 1 artist: Ed Sheeran

INSERT INTO Artist (artist_name, artist_image) VALUES
('Ed Sheeran', '/public/images/artists/ed-sheeran.jpg');

-- ============================================
-- 4. THÊM DỮ LIỆU ALBUM
-- ============================================
-- Chỉ thêm 1 album: ÷ (Divide) của Ed Sheeran

INSERT INTO Album (album_name, album_image, name_artist, album_new) VALUES
('÷ (Divide)', '/public/images/albums/divide.jpg', 'Ed Sheeran', 0);

-- ============================================
-- 5. THÊM DỮ LIỆU PLAYLIST
-- ============================================
-- Chỉ thêm 1 playlist: Today's Top Hits

INSERT INTO Playlist (playlist_name, playlist_image, mood_today) VALUES
('Today\'s Top Hits', '/public/images/playlists/tophits.jpg', 1);

-- ============================================
-- 6. THÊM DỮ LIỆU SONG (Bài hát)
-- ============================================
-- Chỉ thêm 1 bài hát: Shape of You
-- album_id = 1, playlist_id = 1, topic_id = 1

INSERT INTO Song (song_name, song_image, song_url, album_id, playlist_id, topic_id, download) VALUES
('Vet Mua', '/public/images/songs/vetmua.png', '/public/audio/vetmua.mp3', 1, 1, 1, '/public/audio/vetmua.mp3'),
('Shape of You', '/public/images/songs/shape.jpg', '/public/audio/shape_of_you.mp3', 1, 1, 1, '/public/audio/shape_of_you.mp3');

-- ============================================
-- 7. THÊM DỮ LIỆU MUSIC VIDEO
-- ============================================
-- Chỉ thêm 1 music video: Shape of You MV
-- artist_id = 1, topic_id = 1

INSERT INTO Music_Video (music_video_name, music_video_image, music_video_time, music_video_proposal_new, artist_id, topic_id) VALUES
('Vet Mua', '/public/images/mv/vetmua.png', '3:53', 0, 1, 1),
('Shape of You MV', '/public/images/mv/shape.jpg', '3:53', 0, 1, 1);

-- ============================================g
-- 8. THÊM DỮ LIỆU LYRIC (Lời bài hát)
-- ============================================
-- Lời bài hát cho bài "Shape of You" (song_id = 1)

INSERT INTO LYRIC (song_id, lyric_text, startMs) VALUES
(1, 'The club isn\'t the best place to find a lover', 0),
(1, 'So the bar is where I go', 3000),
(1, 'Me and my friends at the table doing shots', 6000),
(1, 'Drinking fast and then we talk slow', 9000),
(1, 'You come over and start up a conversation with just me', 12000),
(1, 'And trust me I\'ll give it a chance now', 15000),
(1, 'Take my hand, stop, put Van the Man on the jukebox', 18000),
(1, 'And then we start to dance, and now I\'m singing like', 21000),
(1, 'Girl, you know I want your love', 24000),
(1, 'Your love was handmade for somebody like me', 27000);

-- ============================================
-- 9. THÊM DỮ LIỆU ALBUM_LOVE (Album yêu thích)
-- ============================================
-- Thêm Shape of You vào album_love để test (song_id = 1)

INSERT INTO album_love (song_id) VALUES
(1);

-- ============================================
-- HOÀN TẤT
-- ============================================

SELECT 'Dữ liệu mẫu đã được thêm thành công!' AS Status;
SELECT 'Chỉ có dữ liệu cho bài hát "Shape of You" để test nhanh' AS Note;
SELECT COUNT(*) AS total_songs FROM Song;
SELECT COUNT(*) AS total_albums FROM Album;
SELECT COUNT(*) AS total_playlists FROM Playlist;
SELECT COUNT(*) AS total_artists FROM Artist;
SELECT COUNT(*) AS total_categories FROM Category;
SELECT COUNT(*) AS total_topics FROM Topic;
SELECT COUNT(*) AS total_music_videos FROM Music_Video;
SELECT COUNT(*) AS total_lyrics FROM LYRIC;
SELECT COUNT(*) AS total_album_love FROM album_love;
