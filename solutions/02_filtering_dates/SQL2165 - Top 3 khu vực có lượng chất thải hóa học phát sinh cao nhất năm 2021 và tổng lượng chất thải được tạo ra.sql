-- Problem: SQL2165 - Top 3 khu vực có lượng chất thải hóa học phát sinh cao nhất năm 2021 và tổng lượng chất thải được tạo ra..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
