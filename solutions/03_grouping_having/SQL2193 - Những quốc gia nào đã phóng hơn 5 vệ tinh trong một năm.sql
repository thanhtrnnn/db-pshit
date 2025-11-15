SELECT
  country,
  SUM(satellites) AS total_satellites
FROM international_satellite_launches
GROUP BY
  country,
  launch_year
HAVING
  SUM(satellites) > 5;