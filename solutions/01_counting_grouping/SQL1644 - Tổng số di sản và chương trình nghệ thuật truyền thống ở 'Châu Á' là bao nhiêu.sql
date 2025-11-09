-- SQL1644: Tổng số di sản và nghệ thuật truyền thống ở 'Châu Á'
-- Bảng: heritage_sites(id, name, location), traditional_arts(id, name, location)
-- Yêu cầu: Đếm số bản ghi có location = 'Châu Á' trong mỗi bảng, kết hợp hiển thị (mỗi bảng một hàng)

SELECT COUNT(*) AS total
FROM heritage_sites
WHERE location = 'Châu Á'
UNION ALL
SELECT COUNT(*) AS total
FROM traditional_arts
WHERE location = 'Châu Á';

