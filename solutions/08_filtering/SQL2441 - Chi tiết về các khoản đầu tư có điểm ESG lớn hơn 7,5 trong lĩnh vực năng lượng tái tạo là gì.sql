-- Tables: esg_factors, impact_investments
-- Technique: JOIN (dialect: Mysql)
SELECT
    ii.project,
    ii.location,
    ii.amount,
    ef.environment,
    ef.social,
    ef.governance
FROM
    impact_investments AS ii
JOIN
    esg_factors AS ef
    ON ii.company_id = ef.company_id
WHERE
    ii.sector = 'Renewable Energy'
    AND (ef.environment + ef.social + ef.governance) > 7.5;