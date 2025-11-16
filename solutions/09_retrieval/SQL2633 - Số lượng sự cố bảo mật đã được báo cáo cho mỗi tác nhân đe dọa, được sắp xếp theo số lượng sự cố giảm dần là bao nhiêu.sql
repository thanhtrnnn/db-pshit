-- Tables: threat_actors
-- Technique: SELECT, ORDER BY (dialect: Mysql)

SELECT
  actor,
  incident_count AS total_incidents
FROM
  threat_actors
ORDER BY
  total_incidents DESC;