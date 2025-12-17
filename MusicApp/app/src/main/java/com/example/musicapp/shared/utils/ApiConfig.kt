package com.example.musicapp.shared.utils

import com.example.musicapp.shared.utils.constant.ManagerUrl

/**
 * Helper object để quản lý URL và convert đường dẫn tương đối thành URL đầy đủ
 * Hỗ trợ static files system từ server
 */
object ApiConfig {
    /**
     * Base URL cho API endpoints (có /api/)
     */
    val API_BASE_URL: String = ManagerUrl.BASE_URL
    
    /**
     * Base URL cho static files (không có /api/)
     * Được sử dụng để serve audio, video, images từ thư mục public/
     */
    val STATIC_BASE_URL: String = ManagerUrl.BASE_URL
        .removeSuffix("/api/")
        .removeSuffix("/api")
    
    /**
     * Convert đường dẫn tương đối hoặc URL thành URL đầy đủ
     * 
     * @param path Đường dẫn từ server (có thể là URL đầy đủ hoặc đường dẫn tương đối như /public/audio/...)
     * @return URL đầy đủ hoặc null nếu path rỗng
     * 
     * Ví dụ:
     * - Input: "/public/audio/song.mp3" -> Output: "http://172.16.0.2:3000/public/audio/song.mp3"
     * - Input: "http://example.com/song.mp3" -> Output: "http://example.com/song.mp3" (giữ nguyên)
     * - Input: "https://youtube.com/watch?v=xxx" -> Output: "https://youtube.com/watch?v=xxx" (giữ nguyên)
     */
    fun getFullUrl(path: String?): String? {
        if (path.isNullOrBlank()) {
            return null
        }
        
        // Nếu đã là URL đầy đủ (http:// hoặc https://), trả về nguyên
        if (path.startsWith("http://") || path.startsWith("https://")) {
            return path
        }
        
        // Nếu là đường dẫn tương đối từ server (bắt đầu bằng /), thêm STATIC_BASE_URL
        return if (path.startsWith("/")) {
            "$STATIC_BASE_URL$path"
        } else {
            // Nếu không bắt đầu bằng /, thêm / vào trước
            "$STATIC_BASE_URL/$path"
        }
    }
    
    /**
     * Kiểm tra xem path có phải là URL đầy đủ không
     */
    fun isFullUrl(path: String?): Boolean {
        return !path.isNullOrBlank() && 
               (path.startsWith("http://") || path.startsWith("https://"))
    }
    
    /**
     * Kiểm tra xem path có phải là đường dẫn tương đối từ server không
     */
    fun isRelativePath(path: String?): Boolean {
        return !path.isNullOrBlank() && 
               path.startsWith("/") && 
               !isFullUrl(path)
    }
}

