-- Tables: visual_arts_programs, workshops
-- Technique: UNION ALL (dialect: Mysql)

SELECT
    'visual_arts_program' AS event,
    visitor_age,
    COUNT(*) AS total
FROM
    visual_arts_programs
WHERE
    underrepresented_community = TRUE
GROUP BY
    visitor_age

UNION ALL

SELECT
    'workshop' AS event,
    visitor_age,
    COUNT(*) AS total
FROM
    workshops
WHERE
    underrepresented_community = TRUE
GROUP BY
    visitor_age
ORDER BY
    event, visitor_age;