-- Tables: psychology_accommodations, social_work_accommodations
-- Technique: INNER JOIN (dialect: Mysql)

SELECT
    p.student_id
FROM
    psychology_accommodations AS p
JOIN
    social_work_accommodations AS s
ON
    p.student_id = s.student_id
WHERE
    p.semester = 'fall 2022' AND s.semester = 'fall 2022';