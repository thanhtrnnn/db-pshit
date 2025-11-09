-- Problem: SQL2791 - Tổng doanh thu từ các khách sạn thân thiện với môi trường và các chuyến thăm bảo tàng tại Đức là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
