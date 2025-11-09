-- Problem: SQL2136 - Chèn kỷ lục mới về doanh số bán 'Hệ thống tên lửa' tới 'Châu Âu' vào năm '2026' với số lượng 30 và giá trị 25000000.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
