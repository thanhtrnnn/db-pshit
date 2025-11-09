-- Problem: SQL2162 - Cập nhật hồ sơ của những người quyên góp có tên 'John' và thêm khoản tiền thưởng $250 quyên góp được thực hiện vào ngày 31 tháng 12 năm 2022.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
