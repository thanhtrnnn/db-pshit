-- Problem: SQL1986 - Cập nhật bản ghi nhiệt độ cho một cảm biến_id cụ thể nếu nhiệt độ cao hơn ngưỡng được chỉ định..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
