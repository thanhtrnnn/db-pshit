 -- Tables: regions, teachers, courses
 -- Technique: JOIN, Filtering (dialect: Mysql)
 SELECT
  COUNT(c.course_id)
 FROM
  courses AS c
 JOIN
  teachers AS t ON c.teacher_id = t.teacher_id
 WHERE
  t.region = 'East' AND YEAR(c.completion_date) = 2023;