-- Tables: libraries, community_centers
-- Technique: UNION ALL (dialect: Mysql)

SELECT
    'Library' AS facility_type,
    name,
    location,
    operating_hours
FROM
    libraries
WHERE
    location LIKE '%Chicago%'

UNION ALL

SELECT
    'Community Center' AS facility_type,
    name,
    location,
    operating_hours
FROM
    community_centers
WHERE
    location LIKE '%Chicago%'
ORDER BY
    facility_type, name;