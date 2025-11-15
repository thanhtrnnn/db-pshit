-- Tables: carbon_sequestration
-- Technique: Subquery (dialect: Mysql)

SELECT species
FROM carbon_sequestration
WHERE co2_sequestration > (
    SELECT AVG(co2_sequestration)
    FROM carbon_sequestration
);