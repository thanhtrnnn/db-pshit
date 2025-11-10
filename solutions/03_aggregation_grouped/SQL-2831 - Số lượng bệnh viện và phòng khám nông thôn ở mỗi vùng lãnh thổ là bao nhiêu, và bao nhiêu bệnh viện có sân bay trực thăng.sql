CREATE TEMPORARY TABLE AllTerritories AS
SELECT DISTINCT territory FROM hospitals
UNION DISTINCT
SELECT DISTINCT territory FROM clinics;

SELECT
    t.territory,
    COALESCE(h_agg.num_hospitals, 0) AS num_hospitals,
    COALESCE(c_agg.num_clinics, 0) AS num_clinics,
    COALESCE(h_agg.num_hospitals_with_helipad, 0) AS num_hospitals_with_helipad
FROM AllTerritories AS t
LEFT JOIN (
    SELECT
        territory,
        COUNT(id) AS num_hospitals,
        SUM(has_helipad) AS num_hospitals_with_helipad
    FROM hospitals
    GROUP BY territory
) AS h_agg ON t.territory = h_agg.territory
LEFT JOIN (
    SELECT
        territory,
        COUNT(id) AS num_clinics
    FROM clinics
    GROUP BY territory
) AS c_agg ON t.territory = c_agg.territory
ORDER BY t.territory;

DROP TEMPORARY TABLE AllTerritories;