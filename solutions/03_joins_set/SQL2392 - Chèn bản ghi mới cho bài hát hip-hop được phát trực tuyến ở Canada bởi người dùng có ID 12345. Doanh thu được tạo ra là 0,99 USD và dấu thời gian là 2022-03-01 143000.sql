-- Problem: SQL2392 - Chèn bản ghi mới cho bài hát hip-hop được phát trực tuyến ở Canada bởi người dùng có ID 12345. Doanh thu được tạo ra là 0,99 USD và dấu thời gian là 2022-03-01 143000..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
