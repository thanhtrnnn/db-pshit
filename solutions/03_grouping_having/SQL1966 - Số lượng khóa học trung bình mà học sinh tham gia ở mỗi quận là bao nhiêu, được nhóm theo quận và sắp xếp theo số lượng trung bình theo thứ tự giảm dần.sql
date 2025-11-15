-- Tables: school_districts, students
-- Technique: JOIN, GROUP BY, AVG (dialect: MySQL)

SELECT
  sd.district_name,
  AVG(s.num_courses) AS average_courses_per_student
FROM students AS s
JOIN school_districts AS sd
  ON s.district_id = sd.district_id
GROUP BY
  sd.district_name
ORDER BY
  average_courses_per_student DESC;