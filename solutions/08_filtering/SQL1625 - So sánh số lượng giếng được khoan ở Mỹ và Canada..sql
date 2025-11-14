--- Tables: wells
--- Technique: aggregation (dialect: Sql Server)

SELECT
  country,
  COUNT(well_id) AS num_wells
FROM wells
WHERE
  country IN ('Canada', 'USA')
GROUP BY
  country
ORDER BY
  CASE country
    WHEN 'Canada' THEN 1
    WHEN 'USA' THEN 2
  END;