-- Tables: Volunteers
-- Technique: Filtering, Aggregation (dialect: Mysql)
SELECT
    COUNT(DISTINCT VolunteerID)
FROM
    Volunteers
WHERE
    Hours > 100;