 -- Tables: tangible_heritage, intangible_heritage
 -- Technique: UNION ALL (dialect: Mysql)

SELECT COUNT(id) AS total_heritages
FROM (
    SELECT id FROM tangible_heritage WHERE region = 'Amazon'
    UNION ALL
    SELECT id FROM intangible_heritage WHERE region = 'Amazon'
) AS combined_heritages;