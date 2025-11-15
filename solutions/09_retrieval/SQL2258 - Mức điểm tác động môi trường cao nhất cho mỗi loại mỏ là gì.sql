SELECT
  type,
  MAX(environmental_impact) AS max_impact
FROM mines
GROUP BY
  type;