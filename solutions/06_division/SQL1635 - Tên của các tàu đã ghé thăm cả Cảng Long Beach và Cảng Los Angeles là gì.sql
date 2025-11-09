-- SQL1635: Tàu đã ghé thăm cả cảng có port_id 1 và 2
-- Bảng: port(port_id, port_name), vessel(vessel_id, vessel_name, port_id)
-- Output: vessel_name xuất hiện ở cả port_id=1 và port_id=2

SELECT vessel_name
FROM vessel
WHERE port_id = 1
INTERSECT
SELECT vessel_name
FROM vessel
WHERE port_id = 2
ORDER BY vessel_name;

-- Nếu không có INTERSECT (MySQL), có thể dùng GROUP BY/HAVING trên tên tàu:
-- SELECT vessel_name
-- FROM vessel
-- WHERE port_id IN (1, 2)
-- GROUP BY vessel_name
-- HAVING COUNT(DISTINCT port_id) = 2
-- ORDER BY vessel_name;
