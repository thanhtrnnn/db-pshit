-- Problem: SQL1994 - Tỷ lệ phần trăm người dùng đã đăng một tweet trong tháng qua và sống ở một quốc gia có dân số trên 100 triệu người, trong tổng số tất cả người dùng ở một quốc gia có dân số trên 100 triệu người là bao nhiêu.txt
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
