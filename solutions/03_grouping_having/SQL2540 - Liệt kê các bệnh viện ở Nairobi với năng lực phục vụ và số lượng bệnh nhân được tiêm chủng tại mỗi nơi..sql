-- Tables: hospitals, patient_vaccinations
-- Technique: LEFT JOIN, GROUP BY (dialect: Mysql)
SELECT
    h.name,
    h.capacity,
    COUNT(DISTINCT pv.patient_id) AS vaccinated
FROM
    hospitals AS h
LEFT JOIN
    patient_vaccinations AS pv ON h.id = pv.hospital_id
WHERE
    h.location = 'Nairobi'
GROUP BY
    h.id, h.name, h.capacity;