-- Tables: MonthlyFruitPrices
-- Technique: Group By (dialect: Mysql)

SELECT
  month,
  AVG(price) AS avg_apple_price
FROM MonthlyFruitPrices
WHERE
  fruit = 'Apples' AND year = 2019
GROUP BY
  month
ORDER BY
  month;