-- Tables: underwriters, policies, policyholders
-- Technique: JOIN, GROUP BY, DATEDIFF (dialect: Mysql)
SELECT
    u.name,
    AVG(DATEDIFF(CURDATE(), p.issue_date)) AS avg_policy_age
FROM
    underwriters AS u
JOIN
    policies AS p ON u.id = p.underwriter_id
JOIN
    policyholders AS ph ON p.id = ph.policy_id
WHERE
    ph.state = 'TX'
GROUP BY
    u.name;