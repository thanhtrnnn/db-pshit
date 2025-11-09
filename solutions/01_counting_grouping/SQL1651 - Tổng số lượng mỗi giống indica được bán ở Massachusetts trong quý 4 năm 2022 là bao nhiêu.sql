-- SQL1651: Tổng số lượng mỗi giống 'indica' bán ở Massachusetts trong Q4 năm 2022
-- Bảng: Cultivars(id, name, type), Inventory(id, cultivar_id, quantity, dispensary_id), Sales(id, inventory_id, quantity, sale_date), (giả định dispensaries(dispensary_id, state)) nếu cần lọc bang.
-- Output: cultivar_name | total_quantity (theo sample mô tả)
-- Giả định: cần join Inventory -> Sales để lấy lượng bán; lọc Cultivars.type='indica'; lọc dispensary thuộc Massachusetts; Q4 = tháng 10-12.
-- Nếu state nằm trong Inventory hoặc dispensary bảng khác; ở đây minh họa với dispensaries.

SELECT c.name AS cultivar_name,
       SUM(s.quantity) AS total_quantity
FROM Cultivars c
JOIN Inventory i ON i.cultivar_id = c.id
JOIN Sales s ON s.inventory_id = i.id
JOIN dispensaries d ON d.id = i.dispensary_id
WHERE c.type = 'indica'
  AND d.state = 'Massachusetts'
  AND s.sale_date BETWEEN '2022-10-01' AND '2022-12-31'
GROUP BY c.name
ORDER BY c.name;
