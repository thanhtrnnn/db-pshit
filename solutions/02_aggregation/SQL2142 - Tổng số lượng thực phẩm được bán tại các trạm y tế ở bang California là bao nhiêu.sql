SELECT SUM(quantity_sold) AS quantity_sold
FROM DispensarySales
WHERE product_type = 'Food' AND state = 'California';