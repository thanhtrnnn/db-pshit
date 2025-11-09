-- Problem: SQL1697 - Các dự án nghiên cứu đang diễn ra và nguồn tài trợ của chúng cho các địa điểm khai quật ở Ai Cập là gì.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
