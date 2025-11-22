-- Tables: department, faculty, research_grant
-- Technique: Subquery, Joins (dialect: Mysql)

SELECT
    AVG(faculty_grant_counts.grant_count) AS `AVG(rg.count)`
FROM (
    SELECT
        f.id AS faculty_id,
        COUNT(rg.id) AS grant_count
    FROM
        department AS d
    JOIN
        faculty AS f ON d.id = f.department_id
    LEFT JOIN
        research_grant AS rg ON f.id = rg.faculty_id
    WHERE
        d.name = 'Khoa Kỹ thuật'
    GROUP BY
        f.id
) AS faculty_grant_counts;