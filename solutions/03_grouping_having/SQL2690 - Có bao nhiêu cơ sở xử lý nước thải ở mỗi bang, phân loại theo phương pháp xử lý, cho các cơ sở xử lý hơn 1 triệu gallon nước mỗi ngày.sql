--- Tables: us_treatment_facilities
--- Technique: GROUP BY (dialect: Mysql)
SELECT
  state,
  method,
  COUNT(*) AS num_facilities
FROM
  us_treatment_facilities
WHERE
  capacity > 1000000
GROUP BY
  state,
  method
ORDER BY
  state,
  method;