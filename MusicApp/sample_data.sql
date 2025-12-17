-- ============================================
-- SCRIPT THÊM DỮ LIỆU MẪU CHO MUSIC APP
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

INSERT INTO Category (category_name, category_image) VALUES
('Pop', 'https://example.com/images/category/pop.jpg'),
('Rock', 'https://example.com/images/category/rock.jpg'),
('Hip Hop', 'https://example.com/images/category/hiphop.jpg'),
('R&B', 'https://example.com/images/category/rnb.jpg'),
('Electronic', 'https://example.com/images/category/electronic.jpg'),
('Country', 'https://example.com/images/category/country.jpg'),
('Jazz', 'https://example.com/images/category/jazz.jpg'),
('Classical', 'https://example.com/images/category/classical.jpg');

-- ============================================
-- 2. THÊM DỮ LIỆU TOPIC (Chủ đề)
-- ============================================

INSERT INTO Topic (topic_name, topic_image, category_id) VALUES
('Top Hits', 'https://example.com/images/topic/tophits.jpg', 1),
('Chill Vibes', 'https://example.com/images/topic/chill.jpg', 1),
('Workout', 'https://example.com/images/topic/workout.jpg', 2),
('Party', 'https://example.com/images/topic/party.jpg', 3),
('Relax', 'https://example.com/images/topic/relax.jpg', 4),
('Focus', 'https://example.com/images/topic/focus.jpg', 5),
('Love Songs', 'https://example.com/images/topic/love.jpg', 1),
('Sad Songs', 'https://example.com/images/topic/sad.jpg', 1);

-- ============================================
-- 3. THÊM DỮ LIỆU ARTIST (Nghệ sĩ)
-- ============================================

INSERT INTO Artist (artist_name, artist_image) VALUES
('Taylor Swift', 'https://example.com/images/artists/taylorswift.jpg'),
('Ed Sheeran', 'https://hips.hearstapps.com/hmg-prod/images/ed-sheeran-attends-the-f1-the-movie-european-premiere-at-news-photo-1757689303.pjpeg?crop=1.00xw:0.781xh;0,0.0385xh&resize=640:*'),
('Billie Eilish', 'https://example.com/images/artists/billieeilish.jpg'),
('The Weeknd', 'https://example.com/images/artists/theweeknd.jpg'),
('Ariana Grande', 'https://example.com/images/artists/arianagrande.jpg'),
('Post Malone', 'https://example.com/images/artists/postmalone.jpg'),
('Dua Lipa', 'https://example.com/images/artists/dualipa.jpg'),
('Drake', 'https://example.com/images/artists/drake.jpg'),
('BTS', 'https://example.com/images/artists/bts.jpg'),
('Coldplay', 'https://example.com/images/artists/coldplay.jpg');

-- ============================================
-- 4. THÊM DỮ LIỆU ALBUM
-- ============================================

INSERT INTO Album (album_name, album_image, name_artist, album_new) VALUES
('Midnights', 'https://example.com/images/albums/midnights.jpg', 'Taylor Swift', 1),
('÷ (Divide)', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23fhqLOhUnElm23HLeEOjB67wgPALTPcjLw&s', 'Ed Sheeran', 0),
('Happier Than Ever', 'https://example.com/images/albums/happier.jpg', 'Billie Eilish', 1),
('After Hours', 'https://example.com/images/albums/afterhours.jpg', 'The Weeknd', 0),
('Positions', 'https://example.com/images/albums/positions.jpg', 'Ariana Grande', 1),
('Hollywood\'s Bleeding', 'https://example.com/images/albums/hollywood.jpg', 'Post Malone', 0),
('Future Nostalgia', 'https://example.com/images/albums/future.jpg', 'Dua Lipa', 1),
('Scorpion', 'https://example.com/images/albums/scorpion.jpg', 'Drake', 0),
('BE', 'https://example.com/images/albums/be.jpg', 'BTS', 1),
('Music of the Spheres', 'https://example.com/images/albums/spheres.jpg', 'Coldplay', 1);

-- ============================================
-- 5. THÊM DỮ LIỆU PLAYLIST
-- ============================================

INSERT INTO Playlist (playlist_name, playlist_image, mood_today) VALUES
('Today\'s Top Hits', 'https://example.com/images/playlists/tophits.jpg', 1),
('Chill Hits', 'https://example.com/images/playlists/chill.jpg', 1),
('Workout Mix', 'https://example.com/images/playlists/workout.jpg', 0),
('Party Playlist', 'https://example.com/images/playlists/party.jpg', 0),
('Relax & Unwind', 'https://example.com/images/playlists/relax.jpg', 0),
('Focus Flow', 'https://example.com/images/playlists/focus.jpg', 0),
('Love Songs 2024', 'https://example.com/images/playlists/love.jpg', 0),
('Sad Hour', 'https://example.com/images/playlists/sad.jpg', 0);

-- ============================================
-- 6. THÊM DỮ LIỆU SONG (Bài hát)
-- ============================================

-- Lưu ý: Thay đổi các URL và ID cho phù hợp với dữ liệu thực tế của bạn

INSERT INTO Song (song_name, song_image, song_url, album_id, playlist_id, topic_id, download) VALUES
-- Album 1: Midnights (Taylor Swift)
('Anti-Hero', 'https://example.com/images/songs/antihero.jpg', 'https://example.com/audio/antihero.mp3', 1, 1, 1, 'https://example.com/download/antihero.mp3'),
('Lavender Haze', 'https://example.com/images/songs/lavender.jpg', 'https://example.com/audio/lavender.mp3', 1, 1, 1, 'https://example.com/download/lavender.mp3'),
('Midnight Rain', 'https://example.com/images/songs/midnight.jpg', 'https://example.com/audio/midnight.mp3', 1, 2, 2, 'https://example.com/download/midnight.mp3'),

-- Album 2: ÷ (Divide) - Ed Sheeran
-- LƯU Ý: song_url phải là URL trực tiếp đến file audio (.mp3, .m4a, etc.), không phải URL trang web
('Shape of You', 'https://example.com/images/songs/shape.jpg', 'https://example.com/audio/shape.mp3', 2, 1, 1, 'https://example.com/download/shape.mp3'),
('Castle on the Hill', 'https://example.com/images/songs/castle.jpg', 'https://example.com/audio/castle.mp3', 2, 3, 3, 'https://example.com/download/castle.mp3'),
('Perfect', 'https://example.com/images/songs/perfect.jpg', 'https://example.com/audio/perfect.mp3', 2, 7, 7, 'https://example.com/download/perfect.mp3'),

-- Album 3: Happier Than Ever - Billie Eilish
('Happier Than Ever', 'https://example.com/images/songs/happier.jpg', 'https://example.com/audio/happier.mp3', 3, 2, 2, 'https://example.com/download/happier.mp3'),
('Therefore I Am', 'https://example.com/images/songs/therefore.jpg', 'https://example.com/audio/therefore.mp3', 3, 1, 1, 'https://example.com/download/therefore.mp3'),
('my future', 'https://example.com/images/songs/future.jpg', 'https://example.com/audio/future.mp3', 3, 5, 5, 'https://example.com/download/future.mp3'),

-- Album 4: After Hours - The Weeknd
('Blinding Lights', 'https://example.com/images/songs/blinding.jpg', 'https://example.com/audio/blinding.mp3', 4, 1, 1, 'https://example.com/download/blinding.mp3'),
('Save Your Tears', 'https://example.com/images/songs/save.jpg', 'https://example.com/audio/save.mp3', 4, 7, 7, 'https://example.com/download/save.mp3'),
('In Your Eyes', 'https://example.com/images/songs/eyes.jpg', 'https://example.com/audio/eyes.mp3', 4, 4, 4, 'https://example.com/download/eyes.mp3'),

-- Album 5: Positions - Ariana Grande
('positions', 'https://example.com/images/songs/positions.jpg', 'https://example.com/audio/positions.mp3', 5, 1, 1, 'https://example.com/download/positions.mp3'),
('34+35', 'https://example.com/images/songs/3435.jpg', 'https://example.com/audio/3435.mp3', 5, 4, 4, 'https://example.com/download/3435.mp3'),
('pov', 'https://example.com/images/songs/pov.jpg', 'https://example.com/audio/pov.mp3', 5, 7, 7, 'https://example.com/download/pov.mp3'),

-- Album 6: Hollywood's Bleeding - Post Malone
('Circles', 'https://example.com/images/songs/circles.jpg', 'https://example.com/audio/circles.mp3', 6, 1, 1, 'https://example.com/download/circles.mp3'),
('Goodbyes', 'https://example.com/images/songs/goodbyes.jpg', 'https://example.com/audio/goodbyes.mp3', 6, 8, 8, 'https://example.com/download/goodbyes.mp3'),
('Sunflower', 'https://example.com/images/songs/sunflower.jpg', 'https://example.com/audio/sunflower.mp3', 6, 2, 2, 'https://example.com/download/sunflower.mp3'),

-- Album 7: Future Nostalgia - Dua Lipa
('Don\'t Start Now', 'https://example.com/images/songs/dontstart.jpg', 'https://example.com/audio/dontstart.mp3', 7, 1, 1, 'https://example.com/download/dontstart.mp3'),
('Levitating', 'https://example.com/images/songs/levitating.jpg', 'https://example.com/audio/levitating.mp3', 7, 4, 4, 'https://example.com/download/levitating.mp3'),
('Physical', 'https://example.com/images/songs/physical.jpg', 'https://example.com/audio/physical.mp3', 7, 3, 3, 'https://example.com/download/physical.mp3'),

-- Album 8: Scorpion - Drake
('God\'s Plan', 'https://example.com/images/songs/godsplan.jpg', 'https://example.com/audio/godsplan.mp3', 8, 1, 1, 'https://example.com/download/godsplan.mp3'),
('In My Feelings', 'https://example.com/images/songs/feelings.jpg', 'https://example.com/audio/feelings.mp3', 8, 4, 4, 'https://example.com/download/feelings.mp3'),
('Nice For What', 'https://example.com/images/songs/nice.jpg', 'https://example.com/audio/nice.mp3', 8, 1, 1, 'https://example.com/download/nice.mp3'),

-- Album 9: BE - BTS
('Life Goes On', 'https://example.com/images/songs/life.jpg', 'https://example.com/audio/life.mp3', 9, 2, 2, 'https://example.com/download/life.mp3'),
('Dynamite', 'https://example.com/images/songs/dynamite.jpg', 'https://example.com/audio/dynamite.mp3', 9, 1, 1, 'https://example.com/download/dynamite.mp3'),
('Blue & Grey', 'https://example.com/images/songs/blue.jpg', 'https://example.com/audio/blue.mp3', 9, 5, 5, 'https://example.com/download/blue.mp3'),

-- Album 10: Music of the Spheres - Coldplay
('Higher Power', 'https://example.com/images/songs/higher.jpg', 'https://example.com/audio/higher.mp3', 10, 1, 1, 'https://example.com/download/higher.mp3'),
('My Universe', 'https://example.com/images/songs/universe.jpg', 'https://example.com/audio/universe.mp3', 10, 1, 1, 'https://example.com/download/universe.mp3'),
('Coloratura', 'https://example.com/images/songs/coloratura.jpg', 'https://example.com/audio/coloratura.mp3', 10, 5, 5, 'https://example.com/download/coloratura.mp3');

-- ============================================
-- 7. THÊM DỮ LIỆU MUSIC VIDEO
-- ============================================

INSERT INTO Music_Video (music_video_name, music_video_image, music_video_time, music_video_proposal_new, artist_id, topic_id) VALUES
('Anti-Hero MV', 'https://example.com/images/mv/antihero.jpg', '3:20', 1, 1, 1),
-- LƯU Ý: music_video_image phải là URL hình ảnh thumbnail, không phải URL YouTube
-- Nếu muốn sử dụng YouTube, cần xử lý riêng trong code ứng dụng
('Shape of You MV', 'https://example.com/images/mv/shape.jpg', '3:53', 0, 2, 1),
('Happier Than Ever MV', 'https://example.com/images/mv/happier.jpg', '4:58', 1, 3, 2),
('Blinding Lights MV', 'https://example.com/images/mv/blinding.jpg', '3:20', 0, 4, 1),
('positions MV', 'https://example.com/images/mv/positions.jpg', '2:52', 1, 5, 1),
('Circles MV', 'https://example.com/images/mv/circles.jpg', '3:35', 0, 6, 1),
('Don\'t Start Now MV', 'https://example.com/images/mv/dontstart.jpg', '3:03', 1, 7, 1),
('God\'s Plan MV', 'https://example.com/images/mv/godsplan.jpg', '5:56', 0, 8, 1),
('Dynamite MV', 'https://example.com/images/mv/dynamite.jpg', '3:19', 1, 9, 1),
('Higher Power MV', 'https://example.com/images/mv/higher.jpg', '3:31', 1, 10, 1);

-- ============================================
-- 8. THÊM DỮ LIỆU LYRIC (Lời bài hát mẫu)
-- ============================================

-- Lời bài hát cho bài "Anti-Hero" (song_id = 1)
INSERT INTO LYRIC (song_id, lyric_text, startMs) VALUES
(1, 'I have this thing where I get older but just never wiser', 0),
(1, 'Midnights become my afternoons', 5000),
(1, 'When my depression works the graveyard shift', 10000),
(1, 'All of the people I\'ve ghosted stand there in the room', 15000),
(1, 'I should not be left to my own devices', 20000),
(1, 'They come with prices and vices', 25000),
(1, 'I end up in crisis', 30000);

-- Lời bài hát cho bài "Shape of You" (song_id = 4)
INSERT INTO LYRIC (song_id, lyric_text, startMs) VALUES
(4, 'The club isn\'t the best place to find a lover', 0),
(4, 'So the bar is where I go', 3000),
(4, 'Me and my friends at the table doing shots', 6000),
(4, 'Drinking fast and then we talk slow', 9000),
(4, 'You come over and start up a conversation with just me', 12000),
(4, 'And trust me I\'ll give it a chance now', 15000),
(4, 'Take my hand, stop, put Van the Man on the jukebox', 18000),
(4, 'And then we start to dance, and now I\'m singing like', 21000);

-- ============================================
-- 9. THÊM DỮ LIỆU ALBUM_LOVE (Album yêu thích)
-- ============================================

-- Thêm một số bài hát vào album_love để test
INSERT INTO album_love (song_id) VALUES
(1), (4), (7), (10), (13), (16), (19), (22), (25), (28);

-- ============================================
-- HOÀN TẤT
-- ============================================

SELECT 'Dữ liệu mẫu đã được thêm thành công!' AS Status;
SELECT COUNT(*) AS total_songs FROM Song;
SELECT COUNT(*) AS total_albums FROM Album;
SELECT COUNT(*) AS total_playlists FROM Playlist;
SELECT COUNT(*) AS total_artists FROM Artist;

