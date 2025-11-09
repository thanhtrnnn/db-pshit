-- Problem: SQL2356 - Tàu chở dầu nào có sức chở hàng hóa cao hơn mức trung bình của tàu chở dầu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
