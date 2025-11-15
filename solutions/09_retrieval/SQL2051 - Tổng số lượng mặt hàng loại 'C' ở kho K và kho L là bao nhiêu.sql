-- Tables: warehouse_k, warehouse_l
-- Technique: UNION ALL (dialect: Mysql)

SELECT quantity AS `Số lượng`
FROM warehouse_k
WHERE item_type = 'C'

UNION ALL

SELECT quantity AS `Số lượng`
FROM warehouse_l
WHERE item_type = 'C';