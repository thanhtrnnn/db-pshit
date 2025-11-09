-- Problem: SQL2354 - Chèn các bản ghi vào bảng landfill_capacity với dữ liệu cho 'Japan', 'Canada', 'Brazil' và các giá trị capacity lần lượt là 10000, 15000, 20000..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
