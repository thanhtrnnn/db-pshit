-- Problem: SQL2270 - Chèn bản ghi mới vào bảng Museum_volunteers dành cho tình nguyện viên từ Ghana đã tham gia vào năm 2021..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
