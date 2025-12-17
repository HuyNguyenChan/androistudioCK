-- ============================================
-- SCRIPT TẠO DATABASE CHO MUSIC APP
-- ============================================

-- Bước 1: Tạo database
CREATE DATABASE IF NOT EXISTS musicapp_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Sử dụng database vừa tạo
USE musicapp_db;

-- ============================================
-- BƯỚC 2: TẠO CÁC BẢNG
-- ============================================

-- Bảng User (Người dùng)
CREATE TABLE IF NOT EXISTS User (
    user_id VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Category (Danh mục)
CREATE TABLE IF NOT EXISTS Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    category_image VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Topic (Chủ đề)
CREATE TABLE IF NOT EXISTS Topic (
    topic_id INT AUTO_INCREMENT PRIMARY KEY,
    topic_name VARCHAR(255) NOT NULL,
    topic_image VARCHAR(500),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Artist (Nghệ sĩ)
CREATE TABLE IF NOT EXISTS Artist (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(255) NOT NULL,
    artist_image VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Album
CREATE TABLE IF NOT EXISTS Album (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_name VARCHAR(255) NOT NULL,
    album_image VARCHAR(500),
    name_artist VARCHAR(255),
    album_new TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Playlist
CREATE TABLE IF NOT EXISTS Playlist (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_name VARCHAR(255) NOT NULL,
    playlist_image VARCHAR(500),
    mood_today TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Song (Bài hát)
CREATE TABLE IF NOT EXISTS Song (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    song_name VARCHAR(255) NOT NULL,
    song_image VARCHAR(500),
    song_url VARCHAR(500),
    album_id INT,
    playlist_id INT,
    topic_id INT,
    download VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES Album(album_id) ON DELETE SET NULL,
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id) ON DELETE SET NULL,
    FOREIGN KEY (topic_id) REFERENCES Topic(topic_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Song_love (Bài hát yêu thích)
CREATE TABLE IF NOT EXISTS song_love (
    song_love_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    song_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES Song(song_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_song (user_id, song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng playlist_user (Playlist của người dùng)
CREATE TABLE IF NOT EXISTS playlist_user (
    playlist_user_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_user_name VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng playlist_user_song (Bài hát trong playlist của người dùng)
CREATE TABLE IF NOT EXISTS playlist_user_song (
    playlist_user_song_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_user_id INT NOT NULL,
    song_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (playlist_user_id) REFERENCES playlist_user(playlist_user_id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES Song(song_id) ON DELETE CASCADE,
    UNIQUE KEY unique_playlist_song (playlist_user_id, song_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng playlist_user_love (Playlist yêu thích của người dùng)
CREATE TABLE IF NOT EXISTS playlist_user_love (
    playlist_user_love_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    playlist_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_playlist (user_id, playlist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Music_Video (Video âm nhạc)
CREATE TABLE IF NOT EXISTS Music_Video (
    music_video_id INT AUTO_INCREMENT PRIMARY KEY,
    music_video_name VARCHAR(255) NOT NULL,
    music_video_image VARCHAR(500),
    music_video_time VARCHAR(50),
    music_video_proposal_new TINYINT(1) DEFAULT 0,
    artist_id INT,
    topic_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE SET NULL,
    FOREIGN KEY (topic_id) REFERENCES Topic(topic_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng LYRIC (Lời bài hát)
CREATE TABLE IF NOT EXISTS LYRIC (
    lyric_id INT AUTO_INCREMENT PRIMARY KEY,
    song_id INT NOT NULL,
    lyric_text TEXT,
    startMs INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (song_id) REFERENCES Song(song_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng FOLLOW (Theo dõi nghệ sĩ)
CREATE TABLE IF NOT EXISTS FOLLOW (
    follow_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    artist_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_artist (user_id, artist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng album_love (Album yêu thích)
CREATE TABLE IF NOT EXISTS album_love (
    album_love_id INT AUTO_INCREMENT PRIMARY KEY,
    song_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (song_id) REFERENCES Song(song_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- BƯỚC 3: TẠO INDEX ĐỂ TỐI ƯU HIỆU SUẤT
-- ============================================

CREATE INDEX idx_song_album ON Song(album_id);
CREATE INDEX idx_song_playlist ON Song(playlist_id);
CREATE INDEX idx_song_topic ON Song(topic_id);
CREATE INDEX idx_playlist_mood ON Playlist(mood_today);
CREATE INDEX idx_album_new ON Album(album_new);
CREATE INDEX idx_song_name ON Song(song_name);
CREATE INDEX idx_playlist_name ON Playlist(playlist_name);
CREATE INDEX idx_album_name ON Album(album_name);
CREATE INDEX idx_music_video_name ON Music_Video(music_video_name);

-- ============================================
-- HOÀN TẤT
-- ============================================
SELECT 'Database và các bảng đã được tạo thành công!' AS Status;

