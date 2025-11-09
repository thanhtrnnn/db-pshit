-- Problem: SQL1845 - Tổng số tiền hỗ trợ tài chính được cung cấp cho người tị nạn ở Jordan và Thổ Nhĩ Kỳ, được nhóm theo tổ chức là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
