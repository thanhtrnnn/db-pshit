-- Tables: Policyholder, Policy
-- Technique: UPDATE with JOIN (dialect: Mysql)
UPDATE Policyholder AS ph
JOIN Policy AS p ON ph.PolicyholderID = p.PolicyholderID
SET ph.Address = '321 Maple St'
WHERE p.Product = 'Home';