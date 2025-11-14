--- Tables: sales
--- Technique: pivoting (dialect: Mysql)

SELECT
    garment_type,
    SUM(CASE WHEN sale_channel = 'online' THEN quantity_sold ELSE 0 END) AS online_sales,
    SUM(CASE WHEN sale_channel = 'cửa hàng' THEN quantity_sold ELSE 0 END) AS store_sales
FROM
    sales
GROUP BY
    garment_type
ORDER BY
    garment_type;