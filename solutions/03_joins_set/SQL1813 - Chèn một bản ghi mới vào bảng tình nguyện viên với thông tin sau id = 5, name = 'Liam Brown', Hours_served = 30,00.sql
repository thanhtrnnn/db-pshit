-- Problem: SQL1813 - Chèn một bản ghi mới vào bảng tình nguyện viên với thông tin sau id = 5, name = 'Liam Brown', Hours_served = 30,00..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
