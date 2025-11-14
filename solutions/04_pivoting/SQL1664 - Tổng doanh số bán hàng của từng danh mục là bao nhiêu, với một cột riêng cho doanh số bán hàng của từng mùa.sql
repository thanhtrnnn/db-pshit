 -- Tables: Trends
 -- Technique: Conditional Aggregation (dialect: Sql Server)

 SELECT
  category,
  SUM(CASE WHEN season = 'Spring' THEN sales ELSE 0 END) AS spring_sales,
  SUM(CASE WHEN season = 'Summer' THEN sales ELSE 0 END) AS summer_sales,
  SUM(CASE WHEN season = 'Fall' THEN sales ELSE 0 END) AS fall_sales,
  SUM(CASE WHEN season = 'Winter' THEN sales ELSE 0 END) AS winter_sales
 FROM
  Trends
 GROUP BY
  category
 ORDER BY
  category;