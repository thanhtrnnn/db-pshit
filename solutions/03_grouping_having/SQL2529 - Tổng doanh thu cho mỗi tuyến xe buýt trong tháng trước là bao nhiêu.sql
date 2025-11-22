--- Tables: bus_routes, fares
--- Technique: JOIN, GROUP BY (dialect: Mysql)

SELECT
  br.route_name,
  SUM(f.fare_amount) AS total_revenue
FROM bus_routes AS br
JOIN fares AS f
  ON br.route_id = f.route_id
WHERE
  YEAR(f.fare_date) = 2025 AND MONTH(f.fare_date) = 5
GROUP BY
  br.route_name;