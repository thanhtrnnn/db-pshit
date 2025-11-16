 -- Tables: ClothingManufacturers
 -- Technique: Group By, Having (dialect: Mysql)

 SELECT
  manufacturer,
  COUNT(item_id) AS total_items
 FROM
  ClothingManufacturers
 GROUP BY
  manufacturer
 HAVING
  COUNT(item_id) < 500;