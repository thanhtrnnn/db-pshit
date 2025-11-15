-- Tables: policy, claims
-- Technique: LEFT JOIN, Aggregate Functions, CASE, GROUP BY WITH ROLLUP (dialect: Mysql)

SELECT
    p.policy_region,
    SUM(CASE WHEN p.policy_region = 'Northeast' THEN c.claim_amount ELSE 0 END) AS northeast_claim_amount,
    SUM(CASE WHEN p.policy_region = 'Southeast' THEN c.claim_amount ELSE 0 END) AS southeast_claim_amount,
    SUM(CASE WHEN p.policy_region = 'Southwest' THEN c.claim_amount ELSE 0 END) AS southwest_claim_amount
FROM
    policy AS p
LEFT JOIN
    claims AS c ON p.policy_id = c.policy_id
GROUP BY
    p.policy_region WITH ROLLUP
ORDER BY
    p.policy_region ASC;