--- Tables: Suppliers, Products
--- Technique: JOIN (dialect: MySQL)
SELECT
    SUM(P.quantity)
FROM
    Suppliers AS S
JOIN
    Products AS P ON S.supplier_id = P.supplier_id
WHERE
    S.country IN ('Africa', 'South America')
    AND P.category = 'clothing';