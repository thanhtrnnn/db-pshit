-- Problem: SQL2283 - Số lần thử đăng nhập đồng thời tối đa được ghi lại cho bất kỳ tài khoản người dùng nào vào một ngày cụ thể là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
