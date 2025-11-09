-- Problem: SQL2622 - Cập nhật tên của tất cả các thư viện ở 'City 1' để bao gồm 'New' ở đầu tên..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
