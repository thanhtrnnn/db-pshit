-- Tables: Volunteers
-- Technique: Group By, Filtering (dialect: Mysql)

SELECT
    program_category AS `Loại chương trình`,
    COUNT(DISTINCT volunteer_id) AS `Tổng số tình nguyện viên`
FROM
    Volunteers
WHERE
    volunteer_date BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY
    program_category;