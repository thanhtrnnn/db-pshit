--- Tables: ice_thickness
--- Technique: GROUP BY (dialect: Mysql)
SELECT
    month,
    AVG(ice_thickness) AS average_ice_thickness
FROM
    ice_thickness
WHERE
    year >= 2010
GROUP BY
    month
ORDER BY
    month;