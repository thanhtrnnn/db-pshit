-- Tables: Animals, Habitats
-- Technique: JOIN, Filtering, Aggregate Function (dialect: MySQL)
SELECT
    COUNT(A.id) AS `SUM(quantity)`
FROM
    Animals AS A
JOIN
    Habitats AS H ON A.habitat_id = H.id
WHERE
    H.name IN ('Môi trường sống A', 'Môi trường sống C');