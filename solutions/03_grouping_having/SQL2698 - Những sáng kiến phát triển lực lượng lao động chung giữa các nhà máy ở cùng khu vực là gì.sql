-- Tables: factories, initiatives
-- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)

SELECT
    f.location,
    i.description
FROM
    initiatives AS i
JOIN
    factories AS f
ON
    i.factory_id = f.factory_id
GROUP BY
    f.location,
    i.description
HAVING
    COUNT(DISTINCT f.factory_id) > 1;