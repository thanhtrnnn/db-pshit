-- Tables: Product_Reviews, Product_Details
-- Technique: JOIN, Subquery, Aggregate functions (dialect: Mysql)

SELECT
    PD.product_id,
    PD.brand
FROM
    Product_Details AS PD
JOIN
    (SELECT
        PR.product_id,
        COUNT(PR.review_id) AS review_count
    FROM
        Product_Reviews AS PR
    WHERE
        PR.preference_rating > 4
    GROUP BY
        PR.product_id
    HAVING
        COUNT(PR.review_id) > 50
    ) AS FilteredReviewedProducts
ON
    PD.product_id = FilteredReviewedProducts.product_id
WHERE
    PD.country IN ('France', 'Germany', 'Italy', 'Spain', 'UK', 'United Kingdom', 'Sweden', 'Netherlands', 'Belgium', 'Austria', 'Switzerland', 'Portugal', 'Ireland', 'Denmark', 'Norway', 'Finland');