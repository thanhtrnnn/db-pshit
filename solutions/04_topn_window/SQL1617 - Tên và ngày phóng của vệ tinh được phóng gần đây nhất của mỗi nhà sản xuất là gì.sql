-- SQL1617: Tên và ngày phóng của vệ tinh được phóng gần đây nhất của mỗi nhà sản xuất
-- Bảng: manufacturers(id, name), satellites(id, manufacturer_id, name, launch_date)
-- Output: manufacturer | satellite | launch_date

WITH ranked AS (
    SELECT m.name  AS manufacturer,
           s.name  AS satellite,
           s.launch_date,
           ROW_NUMBER() OVER (
               PARTITION BY s.manufacturer_id
               ORDER BY s.launch_date DESC
           ) AS rn
    FROM satellites s
    JOIN manufacturers m ON m.id = s.manufacturer_id
)
SELECT manufacturer, satellite, launch_date
FROM ranked
WHERE rn = 1
ORDER BY manufacturer;
