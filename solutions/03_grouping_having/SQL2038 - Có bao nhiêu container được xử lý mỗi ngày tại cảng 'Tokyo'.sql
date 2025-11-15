-- Tables: ports, cargo
-- Technique: JOIN, GROUP BY (dialect: Mysql)

SELECT
    c.handling_date AS `Ngày xử lý`,
    COUNT(c.cargo_id) AS `Tổng số container`
FROM
    cargo AS c
JOIN
    ports AS p ON c.port_id = p.port_id
WHERE
    p.port_name = 'Tokyo'
GROUP BY
    c.handling_date
ORDER BY
    c.handling_date;