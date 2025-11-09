-- SQL1652: Xóa địa điểm sản xuất ở Germany khỏi production_sites
-- Bảng: production_sites(id, site_name, location)

DELETE FROM production_sites
WHERE location = 'Germany';
