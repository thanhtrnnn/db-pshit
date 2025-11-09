-- Problem: SQL169 - Với mỗi phòng ban có mức lương trung bình lớn hơn 30,000, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
