-- Problem: SQL2233 - Có bao nhiêu người tị nạn ở Jordan và Lebanon nhận được hỗ trợ từ các tổ chức quốc tế vào năm 2020.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
