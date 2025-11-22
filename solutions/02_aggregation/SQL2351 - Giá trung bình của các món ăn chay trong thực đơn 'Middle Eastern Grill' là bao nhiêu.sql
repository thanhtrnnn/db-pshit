--- Tables: vegetarian_menu
--- Technique: Aggregate Function (dialect: Mysql)

SELECT AVG(price) AS average_price
FROM vegetarian_menu
WHERE restaurant_name = 'Middle Eastern Grill';