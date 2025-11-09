-- Problem: SQL2665 - Ai là 5 khách hàng hàng đầu với tổng chi tiêu cao nhất cho các sản phẩm cần sa tại các dispensary ở Michigan trong quý trước.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
