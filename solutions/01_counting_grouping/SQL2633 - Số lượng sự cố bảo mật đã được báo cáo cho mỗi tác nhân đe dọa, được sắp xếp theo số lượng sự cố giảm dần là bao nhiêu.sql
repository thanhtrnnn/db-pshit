-- Problem: SQL2633 - Số lượng sự cố bảo mật đã được báo cáo cho mỗi tác nhân đe dọa, được sắp xếp theo số lượng sự cố giảm dần là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
