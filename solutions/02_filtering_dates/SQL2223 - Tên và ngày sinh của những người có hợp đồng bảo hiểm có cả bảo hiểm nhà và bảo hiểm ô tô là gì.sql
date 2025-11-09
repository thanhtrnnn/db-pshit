-- Problem: SQL2223 - Tên và ngày sinh của những người có hợp đồng bảo hiểm có cả bảo hiểm nhà và bảo hiểm ô tô là gì.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
