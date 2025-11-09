-- Problem: SQL2614 - Tổng số lượt khách đến từ các cộng đồng thiểu số cho các chương trình nghệ thuật thị giác và các buổi hội thảo, phân theo nhóm tuổi là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
