-- Problem: SQL2708 - Tổng số chiến dịch gìn giữ hòa bình và các sự kiện ngoại giao quốc phòng trong khu vực Ấn Độ - Thái Bình Dương là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
