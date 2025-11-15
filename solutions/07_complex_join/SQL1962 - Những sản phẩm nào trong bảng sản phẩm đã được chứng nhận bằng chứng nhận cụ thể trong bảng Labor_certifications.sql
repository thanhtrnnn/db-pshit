-- Tables: products, labor_certifications, product_labor_certifications
-- Technique: JOIN (dialect: Mysql)
SELECT DISTINCT
    p.product_name
FROM
    products AS p
JOIN
    product_labor_certifications AS plc ON p.product_id = plc.product_id;