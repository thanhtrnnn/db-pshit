-- Problem: SQL1949 - Tổng giá trị giao dịch của mỗi khách hàng trong tuần qua, chia theo loại tiền tệ, đối với khách hàng ở Hoa Kỳ là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
