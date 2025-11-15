 -- Tables: mining, recycling
 -- Technique: UNION ALL, SUM (dialect: Mysql)

SELECT SUM(combined_quantity) / 12 AS `AVG(quantity)`
FROM (
    SELECT quantity AS combined_quantity
    FROM mining
    WHERE year = 2020 AND element = 'Neodymium'
    UNION ALL
    SELECT quantity AS combined_quantity
    FROM recycling
    WHERE year = 2020 AND element = 'Neodymium'
) AS total_neodymium_2020;