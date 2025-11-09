-- Problem: SQL1818 - Tính nhiệt độ và độ ẩm trung bình cho các nhà kính tiêu thụ năng lượng cao nhất trong tháng vừa qua..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
