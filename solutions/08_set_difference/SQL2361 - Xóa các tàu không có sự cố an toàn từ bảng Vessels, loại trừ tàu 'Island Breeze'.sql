-- Problem: SQL2361 - Xóa các tàu không có sự cố an toàn từ bảng Vessels, loại trừ tàu 'Island Breeze'..html
-- Auto-classified section: 08_set_difference
-- Rationale: Anti-join để lấy A không có trong B (LEFT JOIN ... WHERE b.id IS NULL).
-- Adjust table/column names before running.

-- A but not B template
SELECT a.*
FROM table_a a
LEFT JOIN table_b b ON b.a_id = a.id
WHERE b.a_id IS NULL;
