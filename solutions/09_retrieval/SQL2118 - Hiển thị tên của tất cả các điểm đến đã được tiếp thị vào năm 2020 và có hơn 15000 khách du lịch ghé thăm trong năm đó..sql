-- Tables: marketing_campaigns, tourism_stats
-- Technique: JOIN, Filtering (dialect: Mysql)
SELECT
  mc.destination
FROM marketing_campaigns AS mc
JOIN tourism_stats AS ts
  ON mc.destination = ts.destination AND mc.year = ts.year
WHERE
  mc.year = 2020 AND ts.tourists > 15000;
