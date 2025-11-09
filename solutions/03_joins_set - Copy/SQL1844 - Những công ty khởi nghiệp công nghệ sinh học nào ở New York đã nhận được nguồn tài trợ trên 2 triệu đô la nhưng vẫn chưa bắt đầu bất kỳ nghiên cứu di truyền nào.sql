-- Problem: SQL1844 - Những công ty khởi nghiệp công nghệ sinh học nào ở New York đã nhận được nguồn tài trợ trên 2 triệu đô la nhưng vẫn chưa bắt đầu bất kỳ nghiên cứu di truyền nào.html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
