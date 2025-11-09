-- Problem: SQL1910 - Chèn người dùng mới 'user3' từ 'Ấn Độ' đã tham gia mạng 'xã hội' vào '2023-02-14'..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
