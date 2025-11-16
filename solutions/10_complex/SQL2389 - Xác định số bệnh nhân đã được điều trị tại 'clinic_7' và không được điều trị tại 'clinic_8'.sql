--- Tables: clinic_7, clinic_8
--- Technique: Subquery (dialect: Mysql)
SELECT
  COUNT(c7.patient_id) AS patient_count
FROM clinic_7 AS c7
WHERE
  c7.therapy_received = 1 AND c7.patient_id NOT IN (
    SELECT
      c8.patient_id
    FROM clinic_8 AS c8
    WHERE
      c8.therapy_received = 1
  );