-- Tables: Donations
-- Technique: Aggregation (dialect: Mysql)

SELECT
  AVG(donation_amount) AS avg_donation
FROM Donations
WHERE
  program_area = 'Disaster Relief' AND YEAR(donation_date) = 2020;