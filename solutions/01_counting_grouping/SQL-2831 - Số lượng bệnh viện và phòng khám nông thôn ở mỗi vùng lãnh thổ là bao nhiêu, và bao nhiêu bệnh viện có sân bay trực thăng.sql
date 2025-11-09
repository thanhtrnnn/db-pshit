-- Tables: hospitals, clinics
-- Technique: counting_grouping

SELECT
    ISNULL(h.territory, c.territory) AS territory,
    ISNULL(h.num_hospitals, 0) AS num_hospitals,
    ISNULL(c.num_clinics, 0) AS num_clinics,
    ISNULL(h.num_hospitals_with_helipad, 0) AS num_hospitals_with_helipad
FROM
    (
        SELECT
            territory,
            COUNT(id) AS num_hospitals,
            SUM(CASE WHEN has_helipad = TRUE THEN 1 ELSE 0 END) AS num_hospitals_with_helipad
        FROM
            hospitals
        GROUP BY
            territory
    ) AS h
FULL OUTER JOIN
    (
        SELECT
            territory,
            COUNT(id) AS num_clinics
        FROM
            clinics
        GROUP BY
            territory
    ) AS c
ON
    h.territory = c.territory
ORDER BY
    ISNULL(h.territory, c.territory);