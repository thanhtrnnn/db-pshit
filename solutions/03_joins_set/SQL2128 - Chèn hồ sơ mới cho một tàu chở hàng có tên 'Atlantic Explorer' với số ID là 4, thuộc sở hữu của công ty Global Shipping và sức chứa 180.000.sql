-- Problem: SQL2128 - Chèn hồ sơ mới cho một tàu chở hàng có tên 'Atlantic Explorer' với số ID là 4, thuộc sở hữu của công ty Global Shipping và sức chứa 180.000..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
