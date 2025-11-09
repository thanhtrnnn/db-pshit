-- Problem: SQL2019 - Tổng số lượng hàng may mặc chưa bán được của mỗi thương hiệu, được nhóm theo quốc gia, có số lượng lớn hơn 500 là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
