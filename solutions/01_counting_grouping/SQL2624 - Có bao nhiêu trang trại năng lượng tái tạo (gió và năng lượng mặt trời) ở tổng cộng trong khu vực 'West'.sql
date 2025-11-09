-- Problem: SQL2624 - Có bao nhiêu trang trại năng lượng tái tạo (gió và năng lượng mặt trời) ở tổng cộng trong khu vực 'West'.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
