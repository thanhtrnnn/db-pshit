-- Problem: SQL2269 - Cập nhật chuỗi gene nếu dữ liệu kỹ thuật quá trình sinh học liên quan có giá trị áp suất trên 2.html
-- Auto-classified section: 09_window_sequences
-- Rationale: Dò chuỗi liên tiếp bằng LAG/LEAD trên thứ tự xác định.
-- Adjust table/column names before running.

-- Consecutive sequence detection template
SELECT DISTINCT val
FROM (
  SELECT val,
         LAG(val,1) OVER (ORDER BY id) AS v1,
         LAG(val,2) OVER (ORDER BY id) AS v2
  FROM logs
) t
WHERE val = v1 AND val = v2;
