-- Problem: SQL1814 - Tìm tổng số huy chương mà các vận động viên giành được từ bảng winter_olympics và summer_olympics, không bao gồm những vận động viên có nhiều hơn một huy chương vàng.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
