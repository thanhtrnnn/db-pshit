--- Tables: initiatives, impact
--- Technique: JOIN, GROUP BY, ORDER BY, LIMIT (dialect: MySQL)
SELECT
    i.initiative_name,
    COUNT(DISTINCT imp.student_id) AS students_impacted
FROM
    initiatives AS i
JOIN
    impact AS imp
    ON i.initiative_id = imp.initiative_id
WHERE
    i.community_type = 'Historically Underrepresented'
GROUP BY
    i.initiative_name
ORDER BY
    students_impacted DESC
LIMIT 5;
