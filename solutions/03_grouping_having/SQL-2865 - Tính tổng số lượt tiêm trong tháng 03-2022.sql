--- Tables: hospitals, patient_vaccinations
--- Technique: JOIN (dialect: mysql)

SELECT
  h.name,
  h.capacity,
  COUNT(pv.id) AS total_shots_mar2022,
  ROUND(COALESCE(100.0 * COUNT(pv.id) / h.capacity, 0), 2) AS utilization_pct
FROM
  hospitals h
JOIN
  patient_vaccinations pv ON h.id = pv.hospital_id
WHERE
  YEAR(pv.date) = 2022 AND MONTH(pv.date) = 3
GROUP BY
  h.id,
  h.name,
  h.capacity
ORDER BY
  utilization_pct DESC;