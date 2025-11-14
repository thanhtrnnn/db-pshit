CREATE TEMPORARY TABLE sales (sale_id INT, garment_type VARCHAR(30), sale_channel VARCHAR(10), quantity_sold INT);
INSERT INTO sales (sale_id, garment_type, sale_channel, quantity_sold) VALUES
(1, 'áo', 'online', 5),
(2, 'quần', 'cửa hàng', 3),
(3, 'áo', 'cửa hàng', 2),
(4, 'váy', 'online', 7),
(5, 'quần', 'online', 4),
(6, 'áo', 'online', 6),
(7, 'váy', 'cửa hàng', 1);

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