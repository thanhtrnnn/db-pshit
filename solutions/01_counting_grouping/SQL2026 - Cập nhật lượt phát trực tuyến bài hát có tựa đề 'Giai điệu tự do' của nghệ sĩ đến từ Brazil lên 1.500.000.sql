-- Problem: SQL2026 - Cập nhật lượt phát trực tuyến bài hát có tựa đề 'Giai điệu tự do' của nghệ sĩ đến từ Brazil lên 1.500.000..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
