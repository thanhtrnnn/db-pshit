-- Problem: SQL1966 - Số lượng khóa học trung bình mà học sinh tham gia ở mỗi quận là bao nhiêu, được nhóm theo quận và sắp xếp theo số lượng trung bình theo thứ tự giảm dần.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
