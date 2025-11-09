-- Problem: SQL1755 - Xóa tất cả các lô hàng được thực hiện từ kho 'Rio de Janeiro' đến 'Brazil' trước '2022-02-01'..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
