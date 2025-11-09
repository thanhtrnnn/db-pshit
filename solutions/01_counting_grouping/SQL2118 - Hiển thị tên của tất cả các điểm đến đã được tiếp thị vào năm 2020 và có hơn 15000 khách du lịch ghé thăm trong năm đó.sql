-- Problem: SQL2118 - Hiển thị tên của tất cả các điểm đến đã được tiếp thị vào năm 2020 và có hơn 15000 khách du lịch ghé thăm trong năm đó..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
