-- Solution using NOT EXISTS
SELECT customer_id FROM Customer c
WHERE NOT EXISTS (
	SELECT 1 FROM Product p
	WHERE NOT EXISTS (
		SELECT 1 FROM Customer c2
		WHERE c2.customer_id = c.customer_id AND c2.product_key = p.product_key
	)
);

-- Solution using GROUP BY and HAVING
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);
