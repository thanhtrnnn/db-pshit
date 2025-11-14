 -- Tables: clinic_h, clinic_i
 -- Technique: JOIN (dialect: MySQL)
 SELECT
  COUNT(DISTINCT ch.patient_id)
 FROM
  clinic_h ch
 JOIN
  clinic_i ci ON ch.patient_id = ci.patient_id
 WHERE
  ch.treatment = 'medication' AND ci.treatment = 'medication';