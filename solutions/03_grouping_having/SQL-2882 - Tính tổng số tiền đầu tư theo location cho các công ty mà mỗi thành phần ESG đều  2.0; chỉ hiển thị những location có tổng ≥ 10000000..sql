-- Tables: esg_factors, impact_investments
-- Technique: JOIN, GROUP BY, HAVING (dialect: MySQL)

SELECT
    ii.location,
    SUM(ii.amount) AS total_amount
FROM
    impact_investments AS ii
JOIN
    esg_factors AS ef
ON
    ii.company_id = ef.company_id
WHERE
    ef.environment > 2.0 AND ef.social > 2.0 AND ef.governance > 2.0
GROUP BY
    ii.location
HAVING
    SUM(ii.amount) >= 10000000
ORDER BY
    total_amount DESC;