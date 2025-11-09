-- Problem: SQL2043 - Có bao nhiêu nghệ sĩ từ các cộng đồng ít được đại diện trong lịch sử đã trưng bày tác phẩm của họ trong các phòng trưng bày trong 5 năm qua.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
