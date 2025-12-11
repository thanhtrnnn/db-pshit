SELECT
  p.product_name,
  SUM(s.quantity) AS total_qty
FROM products AS p
JOIN sales AS s
  ON p.product_id = s.product_id
JOIN time AS t
  ON s.time_id = t.time_id
WHERE
  p.vegan = 1 AND p.category = 'Hair Care' AND YEAR(t.sale_date) = 2025
GROUP BY
  p.product_name
ORDER BY
  total_qty DESC;