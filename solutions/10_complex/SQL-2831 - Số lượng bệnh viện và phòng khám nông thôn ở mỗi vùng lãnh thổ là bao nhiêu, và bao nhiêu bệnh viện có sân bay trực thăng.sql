SELECT
  COALESCE(h.territory, c.territory) AS territory,
  COUNT(DISTINCT h.id) AS num_hospitals,
  COUNT(DISTINCT c.id) AS num_clinics,
  SUM(CASE WHEN h.has_helipad = 1 THEN 1 ELSE 0 END) AS num_hospitals_with_helipad
FROM hospitals AS h
LEFT JOIN clinics AS c
  ON h.territory = c.territory
GROUP BY
  COALESCE(h.territory, c.territory)
UNION ALL
SELECT
  c.territory AS territory,
  COUNT(DISTINCT h.id) AS num_hospitals,
  COUNT(DISTINCT c.id) AS num_clinics,
  SUM(CASE WHEN h.has_helipad = 1 THEN 1 ELSE 0 END) AS num_hospitals_with_helipad
FROM clinics AS c
LEFT JOIN hospitals AS h
  ON c.territory = h.territory
WHERE
  h.territory IS NULL
GROUP BY
  c.territory;