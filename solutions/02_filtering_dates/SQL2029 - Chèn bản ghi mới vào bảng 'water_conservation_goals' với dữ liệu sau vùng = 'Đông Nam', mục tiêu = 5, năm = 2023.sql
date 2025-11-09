-- Problem: SQL2029 - Chèn bản ghi mới vào bảng 'water_conservation_goals' với dữ liệu sau vùng = 'Đông Nam', mục tiêu = 5, năm = 2023.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
