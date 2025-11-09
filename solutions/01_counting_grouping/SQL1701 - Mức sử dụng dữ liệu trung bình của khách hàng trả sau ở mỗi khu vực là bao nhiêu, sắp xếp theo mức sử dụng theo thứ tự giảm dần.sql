-- Problem: SQL1701 - Mức sử dụng dữ liệu trung bình của khách hàng trả sau ở mỗi khu vực là bao nhiêu, sắp xếp theo mức sử dụng theo thứ tự giảm dần.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
