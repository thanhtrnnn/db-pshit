-- Tables: union_membership
-- Technique: Group By, Date Functions (dialect: Mysql)

SELECT
    DATE_FORMAT(join_date, '%Y-%m') AS reporting_month,
    COUNT(id) AS new_members_count
FROM
    union_membership
WHERE
    is_new_member = TRUE
GROUP BY
    reporting_month
ORDER BY
    reporting_month;