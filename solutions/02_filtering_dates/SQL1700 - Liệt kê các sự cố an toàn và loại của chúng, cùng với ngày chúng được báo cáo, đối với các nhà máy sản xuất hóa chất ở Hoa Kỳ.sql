-- Problem: SQL1700 - Liệt kê các sự cố an toàn và loại của chúng, cùng với ngày chúng được báo cáo, đối với các nhà máy sản xuất hóa chất ở Hoa Kỳ..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
