-- Problem: SQL2216 - Liệt kê tên và mức sử dụng dữ liệu của tất cả khách hàng ở khu vực 'north' có mức sử dụng dữ liệu lớn hơn mức sử dụng dữ liệu trung bình cho khu vực 'north'..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
