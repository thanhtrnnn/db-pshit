-- Tables: Donors, Donations
-- Technique: GROUP BY (dialect: Mysql)

SELECT
  d.gender,
  COUNT(dn.id) AS total_donations
FROM Donors AS d
JOIN Donations AS dn
  ON d.id = dn.donor_id
GROUP BY
  d.gender;
