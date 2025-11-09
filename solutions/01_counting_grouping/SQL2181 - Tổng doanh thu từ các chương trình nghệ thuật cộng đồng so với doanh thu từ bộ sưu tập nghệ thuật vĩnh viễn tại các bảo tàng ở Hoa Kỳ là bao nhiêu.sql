-- Problem: SQL2181 - Tổng doanh thu từ các chương trình nghệ thuật cộng đồng so với doanh thu từ bộ sưu tập nghệ thuật vĩnh viễn tại các bảo tàng ở Hoa Kỳ là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
