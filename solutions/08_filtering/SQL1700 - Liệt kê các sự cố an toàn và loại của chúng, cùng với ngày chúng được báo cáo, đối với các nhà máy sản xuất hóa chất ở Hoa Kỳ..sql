-- Tables: Safety_Incidents
-- Technique: Filtering (dialect: MySQL)

SELECT
  Plant,
  Incident_Type,
  Report_Date
FROM Safety_Incidents
WHERE
  Plant LIKE '%US%';