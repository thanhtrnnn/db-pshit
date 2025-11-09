-- Problem: SQL2182 - Năm thương hiệu được nhắc đến nhiều nhất bởi người dùng từ Hoa Kỳ và Canada, ngoại trừ các đề cập từ người dùng có ít hơn 100 người theo dõi, là những thương hiệu nào.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
