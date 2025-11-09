-- Problem: SQL1709 - Xóa các buổi trị liệu cho bệnh nhân 5 trước buổi trị liệu đầu tiên của họ vào năm 2023.html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
