-- Tables: Hospitals, Clinics
-- Technique: UNION ALL, Aggregate function (dialect: Mysql)

SELECT COUNT(*) AS `COUNT(*)`
FROM (
    SELECT id FROM Hospitals
    UNION ALL
    SELECT id FROM Clinics
) AS CombinedEntities;