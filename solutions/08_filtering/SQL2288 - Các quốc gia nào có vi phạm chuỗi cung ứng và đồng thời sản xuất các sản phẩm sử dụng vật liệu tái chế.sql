-- Tables: SupplyChainViolations, Products, ProductTransparency
-- Technique: Subquery with IN (dialect: Mysql)

SELECT DISTINCT country
FROM SupplyChainViolations
WHERE num_violations > 0
  AND country IN (
    SELECT p.country
    FROM Products AS p
    JOIN ProductTransparency AS pt
      ON p.product_id = pt.product_id
    WHERE
      pt.recycled_materials = TRUE
  );