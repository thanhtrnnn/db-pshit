-- Problem: SQL2362 - Tổng ngân sách được phân bổ cho mỗi chương trình là bao nhiêu, kể cả những chương trình chưa nhận được nguồn tài trợ nào.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
