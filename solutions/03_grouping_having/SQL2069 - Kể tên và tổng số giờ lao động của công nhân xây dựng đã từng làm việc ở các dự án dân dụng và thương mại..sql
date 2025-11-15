 -- Tables: construction_workers, worker_projects, project_types
 -- Technique: JOIN, GROUP BY, HAVING (dialect: Mysql)

SELECT
    cw.name AS `Tên công nhân xây dựng`,
    SUM(wp.total_labor_hours) AS `Tổng số giờ lao động`
FROM
    construction_workers cw
JOIN
    worker_projects wp ON cw.worker_id = wp.worker_id
JOIN
    project_types pt ON wp.project_id = pt.project_id
WHERE
    pt.project_type IN ('Residential', 'Commercial')
GROUP BY
    cw.worker_id, cw.name
HAVING
    COUNT(DISTINCT pt.project_type) = 2;