-- Problem: SQL2685 - Tên của các giảng viên đã hướng dẫn ít nhất một sinh viên sau đại học và đã công bố ít nhất một nghiên cứu quỹ là gì.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
