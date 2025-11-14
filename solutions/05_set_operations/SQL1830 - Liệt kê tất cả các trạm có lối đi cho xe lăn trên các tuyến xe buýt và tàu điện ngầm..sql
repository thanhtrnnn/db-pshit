-- Tables: stations, bus_stations, subway_stations
-- Technique: UNION, JOIN (dialect: Mysql)
SELECT
    s.station_name
FROM
    stations AS s
JOIN (
    SELECT
        station_id
    FROM
        bus_stations
    WHERE
        is_wheelchair_accessible = TRUE
    UNION
    SELECT
        station_id
    FROM
        subway_stations
    WHERE
        is_wheelchair_accessible = TRUE
) AS accessible_stations ON s.station_id = accessible_stations.station_id;