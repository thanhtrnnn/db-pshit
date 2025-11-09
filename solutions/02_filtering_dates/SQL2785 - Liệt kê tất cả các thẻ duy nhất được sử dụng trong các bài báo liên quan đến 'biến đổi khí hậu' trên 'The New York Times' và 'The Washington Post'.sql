-- Problem: SQL2785 - Liệt kê tất cả các thẻ duy nhất được sử dụng trong các bài báo liên quan đến 'biến đổi khí hậu' trên 'The New York Times' và 'The Washington Post'..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
