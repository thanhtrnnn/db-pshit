-- Problem: SQL2114 - Cập nhật cột game_mode trong bảng game_sessions thành 'Domination' cho tất cả các phiên trên bảng maps có tên 'Space Station'.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
