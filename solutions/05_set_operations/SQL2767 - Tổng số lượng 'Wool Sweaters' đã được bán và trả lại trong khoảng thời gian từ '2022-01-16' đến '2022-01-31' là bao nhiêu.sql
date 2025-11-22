 -- Tables: sales, returns
 -- Technique: UNION ALL (dialect: Mysql)

SELECT SUM(quantity) AS `SUM(s.quantity)`
FROM sales
WHERE product = 'Wool Sweaters'
  AND date BETWEEN '2022-01-16' AND '2022-01-31'

UNION ALL

SELECT SUM(quantity) AS `SUM(s.quantity)`
FROM returns
WHERE product = 'Wool Sweaters'
  AND date BETWEEN '2022-01-16' AND '2022-01-31';