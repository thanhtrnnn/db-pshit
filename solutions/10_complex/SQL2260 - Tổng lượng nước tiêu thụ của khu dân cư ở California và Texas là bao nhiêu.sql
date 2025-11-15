-- Tables: california, texas
-- Technique: UNION ALL, Aggregation (dialect: Mysql)

SELECT
  SUM(t.consumption) AS consumption
FROM
  (
    SELECT
      consumption
    FROM
      california
    WHERE
      sector = 'Residential'
    UNION ALL
    SELECT
      consumption
    FROM
      texas
    WHERE
      sector = 'Residential'
  ) AS t;