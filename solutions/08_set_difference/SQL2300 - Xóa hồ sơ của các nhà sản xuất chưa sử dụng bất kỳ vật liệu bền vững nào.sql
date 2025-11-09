-- Problem: SQL2300 - Xóa hồ sơ của các nhà sản xuất chưa sử dụng bất kỳ vật liệu bền vững nào..html
-- Auto-classified section: 08_set_difference
-- Rationale: Anti-join để lấy A không có trong B (LEFT JOIN ... WHERE b.id IS NULL).
-- Adjust table/column names before running.

-- A but not B template
SELECT a.*
FROM table_a a
LEFT JOIN table_b b ON b.a_id = a.id
WHERE b.a_id IS NULL;
