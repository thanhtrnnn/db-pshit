--- Tables: regions, mobile_services, broadband_services
--- Technique: LEFT JOIN with subqueries (dialect: Mysql)
SELECT
    r.region_name,
    COALESCE(ms.mobile_revenue, 0) AS mobile_revenue,
    COALESCE(bs.broadband_revenue, 0) AS broadband_revenue,
    COALESCE(ms.mobile_revenue, 0) + COALESCE(bs.broadband_revenue, 0) AS total_revenue
FROM
    regions AS r
LEFT JOIN
    (SELECT region_id, SUM(revenue) AS mobile_revenue FROM mobile_services GROUP BY region_id) AS ms
ON r.region_id = ms.region_id
LEFT JOIN
    (SELECT region_id, SUM(revenue) AS broadband_revenue FROM broadband_services GROUP BY region_id) AS bs
ON r.region_id = bs.region_id
ORDER BY
    r.region_id;