-- Tables: customers, orders
-- Technique: JOIN, GROUP BY, ORDER BY, LIMIT (dialect: Mysql)
SELECT
  c.name,
  SUM(o.price) AS total_spending
FROM customers AS c
JOIN orders AS o
  ON c.id = o.customer_id
WHERE
  c.state = 'Michigan' AND o.item_type = 'Cannabis' AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY
  c.name
ORDER BY
  total_spending DESC
LIMIT 5;