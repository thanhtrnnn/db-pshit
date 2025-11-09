-- Problem: SQL2185 - Hiển thị tất cả thiết bị quân sự và số lượng tương ứng đã được bán cho Ấn Độ từ bảng AirForce_Equipment hoặc Army_Equipment..html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
