-- SQL1621: Đếm số lượng trang trại năng lượng tái tạo (gió và mặt trời)
-- Bảng: wind_farms(id, name, region, capacity, efficiency)
--        solar_farms(id, name, region, capacity, efficiency)
-- Output mẫu hiển thị mỗi loại (wind trước, solar sau) dưới dạng total_farms trên 2 hàng

SELECT COUNT(*) AS total_farms FROM wind_farms
UNION ALL
SELECT COUNT(*) AS total_farms FROM solar_farms;
-- Problem: SQL1621 - Có tổng cộng bao nhiêu trang trại năng lượng tái tạo (gió và mặt trời).html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
