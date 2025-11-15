 -- Tables: Clothing_Categories, Items
 -- Technique: Group By, Order By, Limit (dialect: Mysql)

 SELECT
  CC.category_name,
  COUNT(I.item_id) AS size_inclusive_item_count
 FROM
  Clothing_Categories AS CC
 JOIN
  Items AS I
  ON CC.category_id = I.category_id
 WHERE
  I.is_size_inclusive = TRUE
 GROUP BY
  CC.category_name
 ORDER BY
  size_inclusive_item_count DESC
 LIMIT 3;