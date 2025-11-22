-- Tables: marine_species_status, oceanography
-- Technique: UNION ALL (dialect: Mysql)

SELECT
    ocean,
    COUNT(*) AS count_val
FROM
    marine_species_status
WHERE
    ocean != 'Đại Dương Nam Cực'
GROUP BY
    ocean

UNION ALL

SELECT
    'Tổng cộng' AS ocean,
    COUNT(DISTINCT species_name) AS count_val
FROM
    oceanography
ORDER BY
    CASE
        WHEN ocean = 'Tổng cộng' THEN 2
        ELSE 1
    END,
    ocean;