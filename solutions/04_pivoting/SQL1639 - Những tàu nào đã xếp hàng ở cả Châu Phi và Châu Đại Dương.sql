 -- Tables: Vessels, CargoLoads
 -- Technique: Aggregation (dialect: Sql Server)
 SELECT
  V.VesselName
 FROM
  Vessels AS V
 JOIN
  CargoLoads AS CL ON V.VesselID = CL.VesselID
 GROUP BY
  V.VesselID, V.VesselName
 HAVING
  SUM(CASE WHEN CL.LoadLocation LIKE 'Africa%' THEN 1 ELSE 0 END) > 0
  AND SUM(CASE WHEN CL.LoadLocation LIKE 'Oceania%' THEN 1 ELSE 0 END) > 0
 ORDER BY
  V.VesselName;
