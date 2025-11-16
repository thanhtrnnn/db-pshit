 -- Tables: chemical_production, chemical_safety
 -- Technique: JOIN (dialect: Mysql)
SELECT DISTINCT
    cp.chemical
FROM
    chemical_production AS cp
JOIN
    chemical_safety AS cs ON cp.chemical = cs.chemical
WHERE
    cp.region = 'Europe' AND cs.safety_rating < 7;