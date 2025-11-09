-- Problem: SQL2197 - Cập nhật trường 'commanding_officer' trong bảng 'intelligence_agency' với giá trị 'J. Smith' nơi 'agency_location' là 'Washington DC'..html
-- Auto-classified section: 03_joins_set
-- Rationale: Kết hợp bảng bằng JOIN để lấy thuộc tính liên quan; giao/hội bằng GROUP BY/HAVING.
-- Adjust table/column names before running.

-- Join / Set intersection template
SELECT a.<col>, b.<col2>
FROM <table_a> a
JOIN <table_b> b ON b.<fk> = a.<pk>;
