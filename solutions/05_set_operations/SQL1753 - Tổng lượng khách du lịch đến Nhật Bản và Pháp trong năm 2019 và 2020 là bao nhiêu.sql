SELECT SUM(total_tourists) AS `SUM(tourists)`
FROM (
    SELECT tourists AS total_tourists
    FROM japan_tourists
    WHERE year IN (2019, 2020)
    UNION ALL
    SELECT tourists AS total_tourists
    FROM france_tourists
    WHERE year IN (2019, 2020)
) AS combined_tourists;