--- Tables: mobile_subscribers, broadband_subscribers
--- Technique: UNION ALL, Aggregation (dialect: Mysql)

SELECT
    SUM(total_fee) AS num_revenue
FROM
    (
        SELECT
            subscription_fee AS total_fee
        FROM
            mobile_subscribers
        WHERE
            YEAR(date) = 2025 AND MONTH(date) = 3

        UNION ALL

        SELECT
            subscription_fee AS total_fee
        FROM
            broadband_subscribers
        WHERE
            YEAR(date) = 2025 AND MONTH(date) = 3
    ) AS combined_subscribers;