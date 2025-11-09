-- Problem: SQL1763 - Kể tên các loài sinh vật biển được tìm thấy ở Đại Tây Dương hoặc Ấn Độ Dương, nhưng không tìm thấy ở cả hai đại dương.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
