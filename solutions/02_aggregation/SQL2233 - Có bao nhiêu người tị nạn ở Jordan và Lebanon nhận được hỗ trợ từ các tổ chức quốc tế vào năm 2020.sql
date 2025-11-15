-- Tables: refugee_support, refugees
-- Technique: Filtering, Counting (dialect: MySQL)

SELECT
  COUNT(*)
FROM refugee_support AS rs
WHERE
  rs.year = 2020 AND rs.country IN ('Jordan', 'Lebanon');