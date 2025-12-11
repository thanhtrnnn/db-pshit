-- Tables: hospitals, patient_vaccinations
-- Technique: JOIN

SELECT
  h.name,
  COUNT(DISTINCT pv.patient_id) AS unique_patients,
  COUNT(pv.id) AS total_shots
FROM hospitals AS h
JOIN patient_vaccinations AS pv
  ON h.id = pv.hospital_id
WHERE
  h.location = 'Nairobi'
  AND pv.date BETWEEN '2022-03-01' AND '2022-03-31'
GROUP BY
  h.name
ORDER BY
  unique_patients DESC,
  total_shots DESC;