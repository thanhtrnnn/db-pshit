 -- Tables: financial_aid
 -- Technique: GROUP BY (dialect: MySQL)
 
 SELECT
  organization,
  SUM(amount) AS total_aid
 FROM
  financial_aid
 WHERE
  country IN ('Jordan', 'Turkey')
 GROUP BY
  organization
 ORDER BY
  organization;