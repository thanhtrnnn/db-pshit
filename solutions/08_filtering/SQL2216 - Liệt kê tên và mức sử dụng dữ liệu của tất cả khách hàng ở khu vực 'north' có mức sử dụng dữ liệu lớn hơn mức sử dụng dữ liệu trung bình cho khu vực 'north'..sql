SELECT
  s.name,
  s.data_usage
FROM subscribers AS s
WHERE
  s.region = 'north' AND s.data_usage > (
    SELECT
      AVG(data_usage)
    FROM subscribers
    WHERE
      region = 'north'
  );