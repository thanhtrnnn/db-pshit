-- Problem: SQL2229 - Chèn một bản ghi mới về mảnh vỡ không gian vào bảng space_debris_monitoring cho một vật thể được phóng bởi Brazil vào năm 2010..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
