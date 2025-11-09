-- Problem: SQL2437 - Tìm số lượng người sáng lập duy nhất và tổng nguồn tài trợ cho các công ty được thành lập trước năm 2015 trong lĩnh vực năng lượng..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
