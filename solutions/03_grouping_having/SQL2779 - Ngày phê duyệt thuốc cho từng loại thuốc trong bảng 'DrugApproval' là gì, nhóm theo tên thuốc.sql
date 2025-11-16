-- Tables: DrugApproval
-- Technique: Group By (dialect: Mysql)

SELECT
    drug_name,
    MIN(approval_date) AS first_approval_date
FROM
    DrugApproval
GROUP BY
    drug_name;