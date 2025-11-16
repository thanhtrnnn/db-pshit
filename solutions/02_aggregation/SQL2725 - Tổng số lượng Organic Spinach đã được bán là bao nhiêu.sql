-- Tables: sales, menu_items
-- Technique: JOIN (dialect: MySQL)

SELECT SUM(s.quantity)
FROM sales AS s
JOIN menu_items AS m ON s.menu_id = m.id
WHERE m.name = 'Organic Spinach';