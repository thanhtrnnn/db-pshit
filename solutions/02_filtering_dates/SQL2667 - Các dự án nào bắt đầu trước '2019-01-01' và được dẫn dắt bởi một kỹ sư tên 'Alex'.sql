-- Problem: SQL2667 - Các dự án nào bắt đầu trước '2019-01-01' và được dẫn dắt bởi một kỹ sư tên 'Alex'.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
