-- Problem: SQL2401 - Hiển thị tổng số mặt hàng được sản xuất bởi mỗi nhà sản xuất quần áo và chỉ hiển thị những nhà sản xuất có ít hơn 500 mặt hàng được sản xuất..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
