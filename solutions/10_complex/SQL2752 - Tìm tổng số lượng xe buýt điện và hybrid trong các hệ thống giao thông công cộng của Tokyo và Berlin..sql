CREATE TABLE tokyo_buses (
  type VARCHAR(20),
  quantity INT
);

CREATE TABLE berlin_buses (
  type VARCHAR(20),
  quantity INT
);

INSERT INTO tokyo_buses (type, quantity) VALUES
('electric', 150),
('hybrid', 200);

INSERT INTO berlin_buses (type, quantity) VALUES
('electric', 180),
('hybrid', 250);

-- Tables: tokyo_buses, berlin_buses
-- Technique: UNION ALL, Aggregate Function (dialect: Mysql)

SELECT
    SUM(combined_buses.quantity) AS `SUM(quantity)`
FROM
    (
        SELECT quantity FROM tokyo_buses
        UNION ALL
        SELECT quantity FROM berlin_buses
    ) AS combined_buses;