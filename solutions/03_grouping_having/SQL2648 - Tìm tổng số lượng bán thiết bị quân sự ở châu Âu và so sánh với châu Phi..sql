-- Tables: MilitaryEquipmentSales
-- Technique: Group By (dialect: Mysql)

SELECT
  region,
  SUM(sale_price) AS `SUM(sale_price)`
FROM MilitaryEquipmentSales
WHERE
  region IN ('Europe', 'Africa')
GROUP BY
  region;