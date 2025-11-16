-- Tables: Farmers, Crops, Irrigation
-- Technique: LEFT JOIN (dialect: Mysql)

SELECT DISTINCT F.name
FROM Farmers AS F
JOIN Crops AS C
  ON F.id = C.Farm_id
LEFT JOIN Irrigation AS I
  ON F.id = I.Farm_id AND I.irrigation_type = 'Drip'
WHERE
  C.growth_stage = 'Harvest' AND I.Farm_id IS NULL;