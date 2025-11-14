--- Tables: Suppliers, Garment_Suppliers, Garments
--- Technique: Joins, Aggregation (dialect: Mysql)

SELECT
    S.supplier_name,
    COUNT(GS.garment_id) AS garments_supplied
FROM
    Suppliers AS S
JOIN
    Garment_Suppliers AS GS ON S.supplier_id = GS.supplier_id
JOIN
    Garments AS G ON GS.garment_id = G.garment_id
WHERE
    G.collection_name = 'Spring 2023'
GROUP BY
    S.supplier_id, S.supplier_name
ORDER BY
    garments_supplied DESC;