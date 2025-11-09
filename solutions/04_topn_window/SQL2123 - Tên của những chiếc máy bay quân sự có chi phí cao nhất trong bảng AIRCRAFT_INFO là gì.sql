-- Problem: SQL2123 - Tên của những chiếc máy bay quân sự có chi phí cao nhất trong bảng AIRCRAFT_INFO là gì.html
-- Auto-classified section: 04_topn_window
-- Rationale: Xếp hạng per-group bằng window functions (ROW_NUMBER/RANK) để chọn Top-N.
-- Adjust table/column names before running.

-- Top-N per group (window) template
SELECT * FROM (
  SELECT <partition_col>, <measure>,
         ROW_NUMBER() OVER (PARTITION BY <partition_col> ORDER BY <measure> DESC) rn
  FROM <table>
) t WHERE rn <= <N>;
