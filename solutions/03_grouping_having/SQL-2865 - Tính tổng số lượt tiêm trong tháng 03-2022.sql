--- Tables: hospitals, patient_vaccinations
--- Technique: JOIN (dialect: mysql)

SELECT
    h.name,
    h.capacity,
    COUNT(pv.id) AS total_shots_mar2022,
    (COUNT(pv.id) * 100.0 / h.capacity) AS utilization_pct
FROM
    hospitals AS h
JOIN
    patient_vaccinations AS pv
ON
    h.id = pv.hospital_id
WHERE
    pv.date >= '2022-03-01'
    AND pv.date <= '2022-03-31'
GROUP BY
    h.id, h.name, h.capacity
HAVING
    COUNT(pv.id) > 0
ORDER BY
    utilization_pct DESC;