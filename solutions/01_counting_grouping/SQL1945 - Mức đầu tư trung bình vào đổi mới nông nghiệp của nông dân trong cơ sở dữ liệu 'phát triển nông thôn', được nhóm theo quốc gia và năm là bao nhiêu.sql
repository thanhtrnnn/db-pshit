-- Problem: SQL1945 - Mức đầu tư trung bình vào đổi mới nông nghiệp của nông dân trong cơ sở dữ liệu 'phát triển nông thôn', được nhóm theo quốc gia và năm là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
