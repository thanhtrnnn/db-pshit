SELECT
  p.category,
  COUNT(DISTINCT p.product_id) AS distinct_products
FROM products AS p
JOIN sales AS s
  ON p.product_id = s.product_id
JOIN time AS t
  ON s.time_id = t.time_id
WHERE
  t.sale_date BETWEEN '2025-07-01' AND '2025-09-30'
GROUP BY
  p.category
HAVING
  COUNT(DISTINCT p.product_id) >= 2
ORDER BY
  distinct_products DESC;