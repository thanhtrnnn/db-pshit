--- Tables: co2_emissions
--- Technique: Conditional Aggregation (dialect: Mysql)

SELECT
    ABS(
        SUM(CASE WHEN country = 'Japan' THEN co2_emissions ELSE 0 END) -
        SUM(CASE WHEN country = 'South Africa' THEN co2_emissions ELSE 0 END)
    ) AS co2_emissions
FROM
    co2_emissions
WHERE
    sector = 'Transport'
    AND country IN ('Japan', 'South Africa');