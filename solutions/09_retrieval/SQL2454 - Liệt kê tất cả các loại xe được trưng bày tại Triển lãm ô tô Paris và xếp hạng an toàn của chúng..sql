 -- Tables: AutoShows, Exhibits, Vehicles
 -- Technique: JOIN (dialect: Mysql)
 SELECT
  V.Name,
  E.SafetyRating
 FROM
  AutoShows AS AS_T
  JOIN Exhibits AS E ON AS_T.Id = E.AutoShowId
  JOIN Vehicles AS V ON E.VehicleId = V.Id
 WHERE
  AS_T.Name = 'Paris Auto Show';