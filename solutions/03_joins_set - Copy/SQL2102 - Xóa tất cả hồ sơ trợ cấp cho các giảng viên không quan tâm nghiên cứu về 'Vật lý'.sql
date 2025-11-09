-- Problem: SQL2102 - Xóa tất cả hồ sơ trợ cấp cho các giảng viên không quan tâm nghiên cứu về 'Vật lý'..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
