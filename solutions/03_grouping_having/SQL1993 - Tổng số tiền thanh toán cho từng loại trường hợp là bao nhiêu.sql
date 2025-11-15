-- Tables: CaseTypes
-- Technique: Group By (dialect: MySQL)
SELECT
  CaseType,
  SUM(BillingAmount) AS TotalBilling
FROM CaseTypes
GROUP BY
  CaseType;