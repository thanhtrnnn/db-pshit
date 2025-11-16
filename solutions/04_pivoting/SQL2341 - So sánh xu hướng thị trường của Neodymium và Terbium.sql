-- Tables: market_trends
-- Technique: Conditional Aggregation (dialect: Mysql)

SELECT
    year,
    MAX(CASE WHEN element = 'Neodymium' THEN price ELSE NULL END) AS Neodymium_Price,
    MAX(CASE WHEN element = 'Terbium' THEN price ELSE NULL END) AS Terbium_Price
FROM
    market_trends
WHERE
    element IN ('Neodymium', 'Terbium')
GROUP BY
    year
ORDER BY
    year;