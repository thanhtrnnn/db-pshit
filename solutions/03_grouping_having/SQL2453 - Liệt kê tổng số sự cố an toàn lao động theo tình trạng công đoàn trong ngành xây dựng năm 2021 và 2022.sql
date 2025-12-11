-- Tables: union_status, workplace_safety_incidents
-- Technique: JOIN, GROUP BY, SUM, WHERE, ORDER BY (dialect: Mysql)

SELECT
    us.union_status,
    wsi.incident_year,
    SUM(wsi.incidents) AS total_incidents
FROM
    workplace_safety_incidents AS wsi
JOIN
    union_status AS us
    ON wsi.union_status_id = us.id
WHERE
    wsi.incident_year IN (2021, 2022)
GROUP BY
    us.union_status,
    wsi.incident_year
ORDER BY
    us.union_status ASC,
    wsi.incident_year ASC;
