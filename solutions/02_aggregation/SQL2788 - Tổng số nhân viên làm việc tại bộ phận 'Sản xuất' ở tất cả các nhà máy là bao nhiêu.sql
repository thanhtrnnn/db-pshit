--- Tables: plants
--- Technique: Filtering, Aggregation (dialect: Mysql)

SELECT
  COUNT(*) AS `SUM(plant_count)`
FROM
  plants
WHERE
  department = 'Manufacturing';