--- Tables: esg_factors, impact_investments
--- Technique: Common Table Expressions (CTE) (dialect: MySQL)

WITH CompanyEnergyInvestments AS (
    SELECT
        company_id,
        SUM(amount) AS total_amount_energy
    FROM
        impact_investments
    WHERE
        sector LIKE '%Energy%'
    GROUP BY
        company_id
),
CompanyESGScore AS (
    SELECT
        company_id,
        SUM(environment + social + governance) AS total_esg
    FROM
        esg_factors
    GROUP BY
        company_id
)
SELECT
    cei.company_id,
    cei.total_amount_energy,
    ces.total_esg
FROM
    CompanyEnergyInvestments cei
JOIN
    CompanyESGScore ces ON cei.company_id = ces.company_id
WHERE
    cei.total_amount_energy > 10000000
    AND ces.total_esg > 7.5
ORDER BY
    cei.total_amount_energy DESC;
