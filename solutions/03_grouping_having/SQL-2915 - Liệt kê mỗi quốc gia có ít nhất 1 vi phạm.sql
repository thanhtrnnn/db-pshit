-- Tables: SupplyChainViolations, Products, ProductTransparency
-- Technique: Joins, Aggregation (dialect: Mysql)

SELECT
    P.country,
    COUNT(P.product_id) AS recycled_products_count
FROM
    Products AS P
JOIN
    ProductTransparency AS PT ON P.product_id = PT.product_id
JOIN
    SupplyChainViolations AS SCV ON P.country = SCV.country
WHERE
    PT.recycled_materials = TRUE
    AND SCV.num_violations >= 1
GROUP BY
    P.country
ORDER BY
    recycled_products_count DESC, P.country;