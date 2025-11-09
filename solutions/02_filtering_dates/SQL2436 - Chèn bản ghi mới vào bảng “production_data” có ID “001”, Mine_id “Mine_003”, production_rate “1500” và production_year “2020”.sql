-- Problem: SQL2436 - Chèn bản ghi mới vào bảng “production_data” có ID “001”, Mine_id “Mine_003”, production_rate “1500” và production_year “2020”.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
