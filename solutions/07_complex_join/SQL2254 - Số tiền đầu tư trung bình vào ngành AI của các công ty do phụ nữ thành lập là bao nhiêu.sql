-- Tables: Companies, Investments, Founders
-- Technique: Joins, Aggregation (dialect: Mysql)

SELECT
    C.Industry,
    AVG(I.InvestmentAmount) AS AvgInvestmentAmount
FROM
    Companies AS C
JOIN
    Founders AS F
    ON C.CompanyID = F.CompanyID
JOIN
    Investments AS I
    ON C.CompanyID = I.CompanyID
WHERE
    C.Industry = 'AI' AND F.Gender = 'Female';