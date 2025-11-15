-- Tables: dept_services
-- Technique: Group By, Aggregate Function (dialect: Mysql)
SELECT
    dept,
    COUNT(service) AS SoLuongDichVu
FROM
    dept_services
GROUP BY
    dept;