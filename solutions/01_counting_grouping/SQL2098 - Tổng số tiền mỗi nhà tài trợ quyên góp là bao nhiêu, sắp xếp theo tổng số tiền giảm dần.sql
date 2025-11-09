-- Problem: SQL2098 - Tổng số tiền mỗi nhà tài trợ quyên góp là bao nhiêu, sắp xếp theo tổng số tiền giảm dần.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
