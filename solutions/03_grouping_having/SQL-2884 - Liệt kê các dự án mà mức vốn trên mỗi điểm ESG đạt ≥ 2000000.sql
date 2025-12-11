-- Tables: esg_factors, impact_investments
-- Technique: JOIN, Calculated Column (dialect: Mysql)

SELECT
    ii.project,
    ii.sector,
    ROUND((ii.amount / (ef.environment + ef.social + ef.governance)), 2) AS amount_per_esg
FROM
    impact_investments AS ii
JOIN
    esg_factors AS ef ON ii.company_id = ef.company_id
WHERE
    (ef.environment + ef.social + ef.governance) <> 0
HAVING
    amount_per_esg >= 2000000
ORDER BY
    amount_per_esg DESC;