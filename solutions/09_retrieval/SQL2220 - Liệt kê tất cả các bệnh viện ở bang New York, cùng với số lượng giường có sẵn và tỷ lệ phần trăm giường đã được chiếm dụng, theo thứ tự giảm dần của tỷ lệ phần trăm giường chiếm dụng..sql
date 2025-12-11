-- Tables: hospitals, occupancy
-- Technique: JOIN (dialect: Mysql)

SELECT
  h.name,
  h.num_beds,
  (o.beds_occupied * 100.0 / h.num_beds) AS pct_occupied
FROM hospitals AS h
JOIN occupancy AS o
  ON h.id = o.hospital_id
WHERE
  h.state = 'New York'
ORDER BY
  pct_occupied DESC;