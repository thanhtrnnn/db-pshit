-- Problem: SQL2663 - Các chủng loại nào được bán tại các cửa hàng dispensary ở các bang cho phép sử dụng cần sa giải trí.html
-- Auto-classified section: 08_set_difference
-- Rationale: Anti-join để lấy A không có trong B (LEFT JOIN ... WHERE b.id IS NULL).
-- Adjust table/column names before running.

-- A but not B template
SELECT a.*
FROM table_a a
LEFT JOIN table_b b ON b.a_id = a.id
WHERE b.a_id IS NULL;
