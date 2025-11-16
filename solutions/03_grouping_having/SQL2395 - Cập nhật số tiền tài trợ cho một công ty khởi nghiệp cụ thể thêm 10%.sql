-- Tables: union_membership
-- Technique: Group By, Filtering (dialect: MySQL)

SELECT
    YEAR(join_date) AS year,
    MONTH(join_date) AS month,
    COUNT(id) AS new_members_count
FROM
    union_membership
WHERE
    state = 'California' AND is_new_member = TRUE
GROUP BY
    YEAR(join_date),
    MONTH(join_date)
ORDER BY
    year,
    month;