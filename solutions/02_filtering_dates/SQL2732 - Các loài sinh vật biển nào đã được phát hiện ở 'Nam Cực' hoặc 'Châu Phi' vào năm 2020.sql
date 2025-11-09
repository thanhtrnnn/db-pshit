-- Problem: SQL2732 - Các loài sinh vật biển nào đã được phát hiện ở 'Nam Cực' hoặc 'Châu Phi' vào năm 2020.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
