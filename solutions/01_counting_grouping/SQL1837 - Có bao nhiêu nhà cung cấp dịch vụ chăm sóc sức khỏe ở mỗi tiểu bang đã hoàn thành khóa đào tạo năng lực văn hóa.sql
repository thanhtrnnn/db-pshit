-- Problem: SQL1837 - Có bao nhiêu nhà cung cấp dịch vụ chăm sóc sức khỏe ở mỗi tiểu bang đã hoàn thành khóa đào tạo năng lực văn hóa.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
