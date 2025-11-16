 -- Tables: fleets, vessels, container_losses
 -- Technique: JOIN, GROUP BY, WHERE (dialect: Mysql)
 
 SELECT
  f.name,
  SUM(cl.lost_containers)
 FROM
  fleets AS f
 JOIN
  vessels AS v ON f.fleet_id = v.fleet_id
 JOIN
  container_losses AS cl ON v.vessel_id = cl.vessel_id
 WHERE
  YEAR(cl.loss_date) = 2021
 GROUP BY
  f.name;