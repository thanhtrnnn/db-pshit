-- Problem: SQL1752 - Tổng số chỗ ở được cung cấp trong học kỳ mùa thu và tổng số chỗ ở được cung cấp trong học kỳ mùa xuân là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
