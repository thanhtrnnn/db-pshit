--- Tables: environmental_impact
--- Technique: Aggregate function (dialect: Mysql)

SELECT AVG(water_consumption)
FROM environmental_impact
WHERE site_id = 7
  AND date BETWEEN '2021-05-01' AND '2021-05-31';