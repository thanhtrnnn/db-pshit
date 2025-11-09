-- Problem: SQL2012 - Liệt kê những người bảo lãnh và độ tuổi hợp đồng trung bình của họ đối với những người có hợp đồng ở Texas, ngoại trừ những người bảo lãnh không có người có hợp đồng ở Texas..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
