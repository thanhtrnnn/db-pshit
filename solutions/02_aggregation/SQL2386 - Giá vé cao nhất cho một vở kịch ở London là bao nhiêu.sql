-- Tables: plays
-- Technique: Aggregation (dialect: Mysql)

SELECT MAX(price)
FROM plays
WHERE location = 'London';