 -- Tables: artists, gallery_exhibits
 -- Technique: JOIN, Filtering (dialect: Mysql)
 
 SELECT
  COUNT(DISTINCT a.id)
 FROM
  artists AS a
 JOIN
  gallery_exhibits AS ge
  ON a.id = ge.artist_id
 WHERE
  a.community IN ('Historically Underrepresented Group 1', 'Historically Underrepresented Group 2')
  AND ge.exhibit_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);