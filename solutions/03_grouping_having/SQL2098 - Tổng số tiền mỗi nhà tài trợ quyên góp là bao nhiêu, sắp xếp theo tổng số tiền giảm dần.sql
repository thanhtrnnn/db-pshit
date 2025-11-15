 -- Tables: Donors
 -- Technique: Aggregation (dialect: Mysql)
 SELECT
  DonorName,
  SUM(TotalDonation) AS TotalDonated
 FROM
  Donors
 GROUP BY
  DonorName
 ORDER BY
  TotalDonated DESC;