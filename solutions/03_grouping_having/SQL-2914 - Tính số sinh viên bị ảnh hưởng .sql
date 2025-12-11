 Lek
-- Tables: initiatives, impact
-- Technique: JOIN, GROUP BY, WHERE (dialect: MySQL)

SELECT
  i.community_type,
  COUNT(DISTINCT imp.student_id) AS students_impacted
FROM initiatives AS i
JOIN impact AS imp
  ON i.initiative_id = imp.initiative_id
WHERE
  i.initiative_date >= '2025-01-01' AND i.initiative_date <= '2025-03-31'
GROUP BY
  i.community_type
ORDER BY
  students_impacted DESC;