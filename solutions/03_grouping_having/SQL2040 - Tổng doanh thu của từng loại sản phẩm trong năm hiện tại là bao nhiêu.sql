-- Tables: sales
-- Technique: Group By (dialect: Mysql)

SELECT
  product_id,
  SUM(revenue) AS total_revenue
FROM sales
WHERE
  YEAR(sale_date) = 2022
GROUP BY
  product_id;