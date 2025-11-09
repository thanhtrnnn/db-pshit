-- Problem: SQL1702 - Hiển thị tên và sở thích nghiên cứu của các nữ giáo sư đã công bố trong lĩnh vực Trí tuệ nhân tạo..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
