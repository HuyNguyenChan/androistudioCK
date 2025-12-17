/**
 * Helper function để chuyển đổi đường dẫn tương đối thành URL đầy đủ
 * Sử dụng khi cần convert đường dẫn từ database thành URL có thể truy cập được
 */

/**
 * Chuyển đổi đường dẫn tương đối thành URL đầy đủ
 * @param {string} path - Đường dẫn tương đối (ví dụ: /public/audio/song.mp3)
 * @param {Object} req - Express request object (để lấy protocol và host)
 * @returns {string} - URL đầy đủ (ví dụ: http://localhost:3000/public/audio/song.mp3)
 */
function getFullUrl(path, req) {
  if (!path) return null;
  
  // Nếu đã là URL đầy đủ (bắt đầu bằng http:// hoặc https://), trả về nguyên
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return path;
  }
  
  // Nếu là đường dẫn tương đối, thêm base URL
  if (path.startsWith('/public/')) {
    const protocol = req.protocol || 'http';
    const host = req.get('host') || 'localhost:3000';
    return `${protocol}://${host}${path}`;
  }
  
  // Nếu không bắt đầu bằng /public/, thêm /public/ vào đầu
  const cleanPath = path.startsWith('/') ? path : `/${path}`;
  const protocol = req.protocol || 'http';
  const host = req.get('host') || 'localhost:3000';
  return `${protocol}://${host}/public${cleanPath}`;
}

/**
 * Chuyển đổi một object có chứa các trường URL thành URL đầy đủ
 * @param {Object} data - Object chứa dữ liệu
 * @param {Array<string>} urlFields - Mảng các tên trường cần convert (ví dụ: ['song_url', 'song_image'])
 * @param {Object} req - Express request object
 * @returns {Object} - Object đã được convert URL
 */
function convertUrlsInObject(data, urlFields, req) {
  if (!data || typeof data !== 'object') return data;
  
  const result = Array.isArray(data) ? [...data] : { ...data };
  
  if (Array.isArray(result)) {
    return result.map(item => convertUrlsInObject(item, urlFields, req));
  }
  
  urlFields.forEach(field => {
    if (result[field]) {
      result[field] = getFullUrl(result[field], req);
    }
  });
  
  return result;
}

module.exports = {
  getFullUrl,
  convertUrlsInObject
};

