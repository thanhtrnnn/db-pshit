-- Problem: SQL1759 - Liệt kê tên của tất cả các cầu thủ NHL đã lập hat-trick (3 bàn) trong một trận đấu, cùng với đội bóng mà họ thi đấu và ngày diễn ra trận đấu..html
-- Auto-classified section: 02_filtering_dates
-- Rationale: Lọc theo thời gian/khoảng ngày và các điều kiện WHERE; có thể cần DATE functions.
-- Adjust table/column names before running.

-- Date filtering template
SELECT *
FROM <table>
WHERE <date_col> BETWEEN '<start-date>' AND '<end-date>';
