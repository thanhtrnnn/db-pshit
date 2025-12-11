-- Tables: hospitals, patient_vaccinations
-- Technique: Window Functions (dialect: mysql)

SELECT
    h.name,
    pv.date AS peak_date,
    COUNT(pv.patient_id) AS peak_shots
FROM
    patient_vaccinations pv
JOIN
    hospitals h ON pv.hospital_id = h.id
GROUP BY
    h.name,
    pv.date
ORDER BY
    peak_shots DESC
LIMIT 3;