-- Problem: SQL1972 - Tìm 5 ứng dụng phi tập trung hàng đầu có tài sản kỹ thuật số độc đáo nhất trên mạng 'Solana'.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
