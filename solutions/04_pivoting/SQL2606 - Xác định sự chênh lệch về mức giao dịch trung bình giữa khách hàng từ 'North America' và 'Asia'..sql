-- Tables: transaction_amounts
-- Technique: Conditional Aggregation (dialect: Mysql)

SELECT
  ABS(
    AVG(CASE WHEN region = 'North America' THEN transaction_amount ELSE NULL END) -
    AVG(CASE WHEN region = 'Asia' THEN transaction_amount ELSE NULL END)
  ) AS avg_difference;
