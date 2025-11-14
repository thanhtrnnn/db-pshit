--- Tables: heritage_sites, traditional_arts
--- Technique: UNION ALL (dialect: Sql Server)

SELECT COUNT(*) AS TotalCount
FROM (
    SELECT id FROM heritage_sites WHERE location = N'Châu Á'
    UNION ALL
    SELECT id FROM traditional_arts WHERE location = N'Châu Á'
) AS CombinedArtsAndHeritage;