-- SQL1629: Tổng số khách hàng có khả năng tài chính ở miền Bắc (North) và miền Tây (West)
-- Bảng: financially_capable(customer_id, region)
-- Output: count (một hàng duy nhất)

SELECT COUNT(*) AS count
FROM financially_capable
WHERE region IN ('North','West');
-- Problem: SQL1629 - Có bao nhiêu khách hàng có khả năng tài chính ở miền Bắc và miền Tây cộng lại.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
