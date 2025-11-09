-- Problem: SQL2211 - Tổng mức đầu tư vào các dự án năng lượng tái tạo ở khu vực Mỹ Latinh trong giai đoạn từ 2010 đến 2015 là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
