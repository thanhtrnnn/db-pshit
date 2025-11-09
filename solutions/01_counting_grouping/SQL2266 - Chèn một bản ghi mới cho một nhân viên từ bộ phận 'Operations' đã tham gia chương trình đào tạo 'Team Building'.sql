-- Problem: SQL2266 - Chèn một bản ghi mới cho một nhân viên từ bộ phận 'Operations' đã tham gia chương trình đào tạo 'Team Building'..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
