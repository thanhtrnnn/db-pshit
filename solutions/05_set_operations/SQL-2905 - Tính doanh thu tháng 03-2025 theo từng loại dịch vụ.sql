-- Tables: mobile_subscribers, broadband_subscribers
-- Technique: UNION ALL (dialect: Mysql)

SELECT
    'broadband' AS service_type,
    SUM(subscription_fee) AS total_revenue
FROM
    broadband_subscribers
WHERE
    date <= '2025-03-31'

UNION ALL

SELECT
    'mobile' AS service_type,
    SUM(subscription_fee) AS total_revenue
FROM
    mobile_subscribers
WHERE
    date <= '2025-03-31'

ORDER BY
    total_revenue DESC;
