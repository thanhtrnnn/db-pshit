 -- Tables: MilitaryEquipmentSales
 -- Technique: Subquery with JOIN (dialect: Mysql)

 SELECT T1.equipment_id
 FROM (
 SELECT DISTINCT equipment_id
 FROM MilitaryEquipmentSales
 WHERE customer_country = 'Hoa Kỳ' AND YEAR(sale_date) < 2015
 ) AS T1
 JOIN (
 SELECT DISTINCT equipment_id
 FROM MilitaryEquipmentSales
 WHERE customer_country = 'Hoa Kỳ' AND YEAR(sale_date) > 2017
 ) AS T2
 ON T1.equipment_id = T2.equipment_id;