-- Problem: SQL2456 - Những loài sinh vật biển nào được tìm thấy ở 'Australia' vào năm 2020 và những sáng kiến ​​kiểm soát ô nhiễm nào đã được thực hiện ở đó từ năm 2015 đến năm 2020.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
