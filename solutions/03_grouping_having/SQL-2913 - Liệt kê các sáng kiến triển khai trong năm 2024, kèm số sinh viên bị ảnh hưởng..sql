 -- Tables: initiatives, impact
 -- Technique: JOIN, GROUP BY, HAVING, ORDER BY (dialect: MySQL)

 SELECT
  i.initiative_name,
  COUNT(imp.student_id) AS students_impacted
 FROM
  initiatives AS i
  JOIN impact AS imp ON i.initiative_id = imp.initiative_id
 WHERE
  YEAR(i.initiative_date) = 2024
 GROUP BY
  i.initiative_name
 HAVING
  COUNT(imp.student_id) >= 2
 ORDER BY
  students_impacted DESC;