-- Problem: SQL1998 - Những mối quan tâm phổ biến về khả năng tiếp cận công nghệ đối với người khiếm thị và khiếm thính trong bảng hỗ trợ tiếp cận là gì.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
