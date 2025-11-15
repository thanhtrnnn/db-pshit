-- Tables: agricultural_innovation_metrics
-- Technique: Group By, Filtering (dialect: MySQL)

SELECT
  region,
  AVG(value) AS avg_metric
FROM agricultural_innovation_metrics
WHERE
  YEAR(measurement_date) = 2022 AND MONTH(measurement_date) IN (1, 2, 3)
GROUP BY
  region;