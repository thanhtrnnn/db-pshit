-- Problem: SQL2323 - Tìm doanh thu trung bình hàng ngày của các khách sạn thân thiện với môi trường ở Đức và Bồ Đào Nha, và số lượng khách tham quan trung bình hàng ngày tới các bảo tàng ở hai quốc gia này.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
