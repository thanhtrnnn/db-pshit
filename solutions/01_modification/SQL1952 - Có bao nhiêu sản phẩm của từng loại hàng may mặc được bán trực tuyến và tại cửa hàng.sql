-- Tables: sales
-- Technique: Group By (dialect: Mysql)

SELECT
    garment_type,
    sale_channel,
    SUM(quantity_sold) AS total_quantity_sold
FROM
    sales
GROUP BY
    garment_type,
    sale_channel
ORDER BY
    garment_type,
    sale_channel;