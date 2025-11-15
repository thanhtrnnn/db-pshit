-- Tables: Vessels, DockingHistory
-- Technique: JOIN, Filtering, Aggregate Function (dialect: Mysql)

SELECT
  MAX(V.AverageSpeed)
FROM Vessels AS V
JOIN DockingHistory AS DH
  ON V.Id = DH.VesselId
WHERE
  DH.Port = 'Tokyo' AND YEAR(DH.DockingDateTime) = 2021 AND MONTH(DH.DockingDateTime) = 7;