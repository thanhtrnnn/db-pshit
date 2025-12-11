SELECT
  CASE WHEN p.vegan = 1 THEN 'true' ELSE 'false' END AS vegan,
  SUM(s.quantity) AS total_qty
FROM sales AS s
JOIN products AS p
  ON s.product_id = p.product_id
JOIN time AS t
  ON s.time_id = t.time_id
WHERE
  p.category IN ('Hair Care', 'Body Care') AND t.sale_date BETWEEN '2025-01-01' AND '2025-06-30'
GROUP BY
  p.vegan
ORDER BY
  total_qty DESC;