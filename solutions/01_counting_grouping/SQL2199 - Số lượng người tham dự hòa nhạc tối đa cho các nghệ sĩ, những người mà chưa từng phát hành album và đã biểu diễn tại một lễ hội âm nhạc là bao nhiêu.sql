-- Problem: SQL2199 - Số lượng người tham dự hòa nhạc tối đa cho các nghệ sĩ, những người mà chưa từng phát hành album và đã biểu diễn tại một lễ hội âm nhạc là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
