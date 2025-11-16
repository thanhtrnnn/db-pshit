-- Tables: Districts
-- Technique: Filtering (dialect: MySQL)

SELECT
    calls,
    crimes
FROM
    Districts
WHERE
    district_name IN ('Trung tâm', 'Phía Tây');