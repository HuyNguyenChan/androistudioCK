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
-- Lưu ý: Đường dẫn tương đối sẽ được server tự động convert thành URL đầy đủ
-- Ví dụ: /public/images/category/pop.jpg -> http://localhost:3000/public/images/category/pop.jpg

INSERT INTO Category (category_name, category_image) VALUES
('Pop', '/public/images/category/pop.jpg'),
('Rock', '/public/images/category/rock.jpg'),
('Hip Hop', '/public/images/category/hiphop.jpg'),
('R&B', '/public/images/category/rnb.jpg'),
('Electronic', '/public/images/category/electronic.jpg'),
('Country', '/public/images/category/country.jpg'),
('Jazz', '/public/images/category/jazz.jpg'),
('Classical', '/public/images/category/classical.jpg');

-- ============================================
-- 2. THÊM DỮ LIỆU TOPIC (Chủ đề)
-- ============================================

INSERT INTO Topic (topic_name, topic_image, category_id) VALUES
('Top Hits', '/public/images/topic/tophits.jpg', 1),
('Chill Vibes', '/public/images/topic/chill.jpg', 1),
('Workout', '/public/images/topic/workout.jpg', 2),
('Party', '/public/images/topic/party.jpg', 3),
('Relax', '/public/images/topic/relax.jpg', 4),
('Focus', '/public/images/topic/focus.jpg', 5),
('Love Songs', '/public/images/topic/love.jpg', 1),
('Sad Songs', '/public/images/topic/sad.jpg', 1);

-- ============================================
-- 3. THÊM DỮ LIỆU ARTIST (Nghệ sĩ)
-- ============================================
-- Lưu ý: Giữ nguyên URL thực tế nếu có, chỉ thay đổi URL example.com

INSERT INTO Artist (artist_name, artist_image) VALUES
('Taylor Swift', '/public/images/artists/taylorswift.jpg'),
('Ed Sheeran', 'https://hips.hearstapps.com/hmg-prod/images/ed-sheeran-attends-the-f1-the-movie-european-premiere-at-news-photo-1757689303.pjpeg?crop=1.00xw:0.781xh;0,0.0385xh&resize=640:*'),
('Billie Eilish', '/public/images/artists/billieeilish.jpg'),
('The Weeknd', '/public/images/artists/theweeknd.jpg'),
('Ariana Grande', '/public/images/artists/arianagrande.jpg'),
('Post Malone', '/public/images/artists/postmalone.jpg'),
('Dua Lipa', '/public/images/artists/dualipa.jpg'),
('Drake', '/public/images/artists/drake.jpg'),
('BTS', '/public/images/artists/bts.jpg'),
('Coldplay', '/public/images/artists/coldplay.jpg');

-- ============================================
-- 4. THÊM DỮ LIỆU ALBUM
-- ============================================

INSERT INTO Album (album_name, album_image, name_artist, album_new) VALUES
('Midnights', '/public/images/albums/midnights.jpg', 'Taylor Swift', 1),
('÷ (Divide)', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23fhqLOhUnElm23HLeEOjB67wgPALTPcjLw&s', 'Ed Sheeran', 0),
('Happier Than Ever', '/public/images/albums/happier.jpg', 'Billie Eilish', 1),
('After Hours', '/public/images/albums/afterhours.jpg', 'The Weeknd', 0),
('Positions', '/public/images/albums/positions.jpg', 'Ariana Grande', 1),
('Hollywood\'s Bleeding', '/public/images/albums/hollywood.jpg', 'Post Malone', 0),
('Future Nostalgia', '/public/images/albums/future.jpg', 'Dua Lipa', 1),
('Scorpion', '/public/images/albums/scorpion.jpg', 'Drake', 0),
('BE', '/public/images/albums/be.jpg', 'BTS', 1),
('Music of the Spheres', '/public/images/albums/spheres.jpg', 'Coldplay', 1);

-- ============================================
-- 5. THÊM DỮ LIỆU PLAYLIST
-- ============================================

INSERT INTO Playlist (playlist_name, playlist_image, mood_today) VALUES
('Today\'s Top Hits', '/public/images/playlists/tophits.jpg', 1),
('Chill Hits', '/public/images/playlists/chill.jpg', 1),
('Workout Mix', '/public/images/playlists/workout.jpg', 0),
('Party Playlist', '/public/images/playlists/party.jpg', 0),
('Relax & Unwind', '/public/images/playlists/relax.jpg', 0),
('Focus Flow', '/public/images/playlists/focus.jpg', 0),
('Love Songs 2024', '/public/images/playlists/love.jpg', 0),
('Sad Hour', '/public/images/playlists/sad.jpg', 0);

-- ============================================
-- 6. THÊM DỮ LIỆU SONG (Bài hát)
-- ============================================
-- Lưu ý: 
-- - Đường dẫn tương đối sẽ được server tự động serve qua /public/
-- - Ví dụ: /public/audio/antihero.mp3 -> http://localhost:3000/public/audio/antihero.mp3
-- - Giữ nguyên URL thực tế nếu có (như zingmp3.vn, youtube.com, etc.)

INSERT INTO Song (song_name, song_image, song_url, album_id, playlist_id, topic_id, download) VALUES
-- Album 1: Midnights (Taylor Swift)
('Anti-Hero', '/public/images/songs/antihero.jpg', '/public/audio/antihero.mp3', 1, 1, 1, '/public/audio/antihero.mp3'),
('Lavender Haze', '/public/images/songs/lavender.jpg', '/public/audio/lavender.mp3', 1, 1, 1, '/public/audio/lavender.mp3'),
('Midnight Rain', '/public/images/songs/midnight.jpg', '/public/audio/midnight.mp3', 1, 2, 2, '/public/audio/midnight.mp3'),

-- Album 2: ÷ (Divide) - Ed Sheeran
('Shape of You', '/public/images/songs/shape.jpg', '/public/audio/shape_of_you.mp3', 2, 1, 1, '/public/audio/shape_of_you.mp3'),
('Castle on the Hill', '/public/images/songs/castle.jpg', '/public/audio/castle.mp3', 2, 3, 3, '/public/audio/castle.mp3'),
('Perfect', '/public/images/songs/perfect.jpg', '/public/audio/perfect.mp3', 2, 7, 7, '/public/audio/perfect.mp3'),

-- Album 3: Happier Than Ever - Billie Eilish
('Happier Than Ever', '/public/images/songs/happier.jpg', '/public/audio/happier.mp3', 3, 2, 2, '/public/audio/happier.mp3'),
('Therefore I Am', '/public/images/songs/therefore.jpg', '/public/audio/therefore.mp3', 3, 1, 1, '/public/audio/therefore.mp3'),
('my future', '/public/images/songs/future.jpg', '/public/audio/future.mp3', 3, 5, 5, '/public/audio/future.mp3'),

-- Album 4: After Hours - The Weeknd
('Blinding Lights', '/public/images/songs/blinding.jpg', '/public/audio/blinding.mp3', 4, 1, 1, '/public/audio/blinding.mp3'),
('Save Your Tears', '/public/images/songs/save.jpg', '/public/audio/save.mp3', 4, 7, 7, '/public/audio/save.mp3'),
('In Your Eyes', '/public/images/songs/eyes.jpg', '/public/audio/eyes.mp3', 4, 4, 4, '/public/audio/eyes.mp3'),

-- Album 5: Positions - Ariana Grande
('positions', '/public/images/songs/positions.jpg', '/public/audio/positions.mp3', 5, 1, 1, '/public/audio/positions.mp3'),
('34+35', '/public/images/songs/3435.jpg', '/public/audio/3435.mp3', 5, 4, 4, '/public/audio/3435.mp3'),
('pov', '/public/images/songs/pov.jpg', '/public/audio/pov.mp3', 5, 7, 7, '/public/audio/pov.mp3'),

-- Album 6: Hollywood's Bleeding - Post Malone
('Circles', '/public/images/songs/circles.jpg', '/public/audio/circles.mp3', 6, 1, 1, '/public/audio/circles.mp3'),
('Goodbyes', '/public/images/songs/goodbyes.jpg', '/public/audio/goodbyes.mp3', 6, 8, 8, '/public/audio/goodbyes.mp3'),
('Sunflower', '/public/images/songs/sunflower.jpg', '/public/audio/sunflower.mp3', 6, 2, 2, '/public/audio/sunflower.mp3'),

-- Album 7: Future Nostalgia - Dua Lipa
('Don\'t Start Now', '/public/images/songs/dontstart.jpg', '/public/audio/dontstart.mp3', 7, 1, 1, '/public/audio/dontstart.mp3'),
('Levitating', '/public/images/songs/levitating.jpg', '/public/audio/levitating.mp3', 7, 4, 4, '/public/audio/levitating.mp3'),
('Physical', '/public/images/songs/physical.jpg', '/public/audio/physical.mp3', 7, 3, 3, '/public/audio/physical.mp3'),

-- Album 8: Scorpion - Drake
('God\'s Plan', '/public/images/songs/godsplan.jpg', '/public/audio/godsplan.mp3', 8, 1, 1, '/public/audio/godsplan.mp3'),
('In My Feelings', '/public/images/songs/feelings.jpg', '/public/audio/feelings.mp3', 8, 4, 4, '/public/audio/feelings.mp3'),
('Nice For What', '/public/images/songs/nice.jpg', '/public/audio/nice.mp3', 8, 1, 1, '/public/audio/nice.mp3'),

-- Album 9: BE - BTS
('Life Goes On', '/public/images/songs/life.jpg', '/public/audio/life.mp3', 9, 2, 2, '/public/audio/life.mp3'),
('Dynamite', '/public/images/songs/dynamite.jpg', '/public/audio/dynamite.mp3', 9, 1, 1, '/public/audio/dynamite.mp3'),
('Blue & Grey', '/public/images/songs/blue.jpg', '/public/audio/blue.mp3', 9, 5, 5, '/public/audio/blue.mp3'),

-- Album 10: Music of the Spheres - Coldplay
('Higher Power', '/public/images/songs/higher.jpg', '/public/audio/higher.mp3', 10, 1, 1, '/public/audio/higher.mp3'),
('My Universe', '/public/images/songs/universe.jpg', '/public/audio/universe.mp3', 10, 1, 1, '/public/audio/universe.mp3'),
('Coloratura', '/public/images/songs/coloratura.jpg', '/public/audio/coloratura.mp3', 10, 5, 5, '/public/audio/coloratura.mp3');

-- ============================================
-- 7. THÊM DỮ LIỆU MUSIC VIDEO
-- ============================================
-- Lưu ý: music_video_image là thumbnail của video, giữ nguyên URL thực tế nếu có

INSERT INTO Music_Video (music_video_name, music_video_image, music_video_time, music_video_proposal_new, artist_id, topic_id) VALUES
('Anti-Hero MV', '/public/images/mv/antihero.jpg', '3:20', 1, 1, 1),
('Shape of You MV', 'https://www.youtube.com/watch?v=JGwWNGJdvx8&list=RDJGwWNGJdvx8&start_radio=1', '3:53', 0, 2, 1),
('Happier Than Ever MV', '/public/images/mv/happier.jpg', '4:58', 1, 3, 2),
('Blinding Lights MV', '/public/images/mv/blinding.jpg', '3:20', 0, 4, 1),
('positions MV', '/public/images/mv/positions.jpg', '2:52', 1, 5, 1),
('Circles MV', '/public/images/mv/circles.jpg', '3:35', 0, 6, 1),
('Don\'t Start Now MV', '/public/images/mv/dontstart.jpg', '3:03', 1, 7, 1),
('God\'s Plan MV', '/public/images/mv/godsplan.jpg', '5:56', 0, 8, 1),
('Dynamite MV', '/public/images/mv/dynamite.jpg', '3:19', 1, 9, 1),
('Higher Power MV', '/public/images/mv/higher.jpg', '3:31', 1, 10, 1);

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

