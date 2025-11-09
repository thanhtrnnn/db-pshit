-- Problem: SQL2134 - Xác định những thành viên đã tham gia các buổi tập luyện trong cả tháng 1 và tháng 2 năm 2022..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
