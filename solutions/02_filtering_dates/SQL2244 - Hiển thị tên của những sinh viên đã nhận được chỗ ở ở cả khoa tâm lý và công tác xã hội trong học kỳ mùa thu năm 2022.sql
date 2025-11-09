-- Problem: SQL2244 - Hiển thị tên của những sinh viên đã nhận được chỗ ở ở cả khoa tâm lý và công tác xã hội trong học kỳ mùa thu năm 2022..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
