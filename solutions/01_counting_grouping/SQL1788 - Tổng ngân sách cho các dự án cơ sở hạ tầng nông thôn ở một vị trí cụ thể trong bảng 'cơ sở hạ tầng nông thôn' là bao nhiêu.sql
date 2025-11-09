-- Problem: SQL1788 - Tổng ngân sách cho các dự án cơ sở hạ tầng nông thôn ở một vị trí cụ thể trong bảng 'cơ sở hạ tầng nông thôn' là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
