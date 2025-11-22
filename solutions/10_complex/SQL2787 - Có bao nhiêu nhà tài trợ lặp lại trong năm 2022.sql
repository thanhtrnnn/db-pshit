 -- Tables: donors
 -- Technique: Subquery (dialect: Mysql)
 SELECT
  COUNT(t.donor_id) AS `COUNT(DISTINCT donor_id)`
 FROM
  (
  SELECT
  donor_id
  FROM
  donors
  WHERE
  YEAR(donation_date) = 2022
  GROUP BY
  donor_id
  HAVING
  COUNT(*) > 1
  ) AS t;