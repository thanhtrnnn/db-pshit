-- Problem: SQL2109 - Tìm số lượng ấn phẩm của các sinh viên tốt nghiệp ở khoa Khoa học Máy tính chưa bao giờ nhận được trợ cấp nghiên cứu..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
