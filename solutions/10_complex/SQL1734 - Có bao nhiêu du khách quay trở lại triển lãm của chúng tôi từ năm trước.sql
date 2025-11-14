 -- Tables: visitors
 -- Technique: Self-join (dialect: Mysql)

 SELECT
  COUNT(DISTINCT v1.id) AS id_kh
 FROM
  visitors AS v1
 JOIN
  visitors AS v2 ON v1.id = v2.id
  AND v1.exhibit_id = v2.exhibit_id
  AND v2.visit_year = v1.visit_year + 1;