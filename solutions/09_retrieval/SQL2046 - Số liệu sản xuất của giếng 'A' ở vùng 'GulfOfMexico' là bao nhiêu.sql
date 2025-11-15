-- Tables: wells, production
-- Technique: JOIN (dialect: MySQL)

SELECT
  p.well_id AS `Mã giếng`,
  p.date AS `Ngày sản xuất`,
  p.quantity AS `Sản lượng dầu`
FROM production AS p
JOIN wells AS w
  ON p.well_id = w.id
WHERE
  w.name = 'A' AND w.region = 'GulfOfMexico';