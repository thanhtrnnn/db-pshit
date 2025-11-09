-- Problem: SQL2342 - Cập nhật bảng 'inventory_data' và đặt 'inventory_status' thành 'low' cho tất cả các bản ghi trong đó 'product_name' là 'Acetone'.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
