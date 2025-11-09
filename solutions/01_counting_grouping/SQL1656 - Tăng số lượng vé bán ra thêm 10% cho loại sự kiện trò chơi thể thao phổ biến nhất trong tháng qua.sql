-- Problem: SQL1656 - Tăng số lượng vé bán ra thêm 10% cho loại sự kiện trò chơi thể thao phổ biến nhất trong tháng qua..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
