--- Tables: r_and_d_data
--- Technique: Filtering (dialect: Sql Server)

SELECT
    expenditure
FROM
    r_and_d_data
WHERE
    drug_name = 'DrugA' AND year = '2020';