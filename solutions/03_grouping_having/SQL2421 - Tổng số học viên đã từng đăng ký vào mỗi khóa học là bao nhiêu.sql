-- Tables: courses, enrollments
-- Technique: JOIN, GROUP BY (dialect: Mysql)

SELECT
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM
    courses AS c
JOIN
    enrollments AS e
ON
    c.course_id = e.course_id
GROUP BY
    c.course_name;