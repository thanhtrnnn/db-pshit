-- SQL1664: Pivot doanh số theo danh mục và mùa
-- Bảng: Trends(category, season, sales_amount)
-- Output: category | total_sales | winter_sales | spring_sales | summer_sales | autumn_sales
-- Technique: Conditional aggregation (SUM(CASE ...)) tạo cột mùa riêng.
-- Phân loại: 05_conditional_pivot (pivot) thay vì counting_grouping.
-- CHANGELOG
-- [2025-11-09] Moved from 01_counting_grouping to 05_conditional_pivot; conditional pivot columns.

SELECT category,
       SUM(sales_amount) AS total_sales,
       SUM(CASE WHEN season = 'Winter' THEN sales_amount ELSE 0 END) AS winter_sales,
       SUM(CASE WHEN season = 'Spring' THEN sales_amount ELSE 0 END) AS spring_sales,
       SUM(CASE WHEN season = 'Summer' THEN sales_amount ELSE 0 END) AS summer_sales,
       SUM(CASE WHEN season = 'Autumn' THEN sales_amount ELSE 0 END) AS autumn_sales
FROM Trends
GROUP BY category
ORDER BY category;
-- SQL1664: Pivot doanh số theo mùa cho từng danh mục
-- Bảng: Trends(id, category, season, sales)
-- Output: category | spring_sales | summer_sales | fall_sales | winter_sales
-- Yêu cầu: hiển thị 0 nếu không có doanh số cho mùa.

SELECT category,
       SUM(CASE WHEN season = 'Spring' THEN sales ELSE 0 END) AS spring_sales,
       SUM(CASE WHEN season = 'Summer' THEN sales ELSE 0 END) AS summer_sales,
       SUM(CASE WHEN season = 'Fall'   THEN sales ELSE 0 END) AS fall_sales,
       SUM(CASE WHEN season = 'Winter' THEN sales ELSE 0 END) AS winter_sales
FROM Trends
GROUP BY category
ORDER BY category;
