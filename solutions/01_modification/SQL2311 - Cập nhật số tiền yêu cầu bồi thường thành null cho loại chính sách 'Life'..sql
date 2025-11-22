-- Tables: Claims, Policy
-- Technique: UPDATE with JOIN (dialect: Mysql)

UPDATE Claims c
JOIN Policy p ON c.PolicyID = p.PolicyID
SET c.ClaimAmount = NULL
WHERE p.PolicyType = 'Life';