SELECT
  p.country,
  COUNT(pt.product_id) AS recycled_products_count
FROM Products AS p
JOIN ProductTransparency AS pt
  ON p.product_id = pt.product_id
WHERE
  pt.recycled_materials = 1
  AND p.country IN (
    SELECT
      country
    FROM SupplyChainViolations
    WHERE
      num_violations >= 1
  )
GROUP BY
  p.country
ORDER BY
  recycled_products_count DESC,
  p.country ASC;