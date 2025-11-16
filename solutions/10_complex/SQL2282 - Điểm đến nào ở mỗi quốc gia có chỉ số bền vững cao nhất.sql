--- Tables: destinations
--- Technique: JOIN with subquery (dialect: MySQL)

SELECT
    d.name,
    d.sustainability_index
FROM
    destinations AS d
JOIN (
    SELECT
        country_id,
        MAX(sustainability_index) AS max_sustainability_index
    FROM
        destinations
    GROUP BY
        country_id
) AS max_indices
ON
    d.country_id = max_indices.country_id AND d.sustainability_index = max_indices.max_sustainability_index;