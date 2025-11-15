-- Tables: users, country_populations, tweets
-- Technique: Conditional Aggregation (dialect: MySQL)

SELECT
    (COUNT(DISTINCT CASE WHEN t.tweet_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) THEN u.user_id END) * 100.0) / COUNT(DISTINCT u.user_id) AS pct_users
FROM
    users u
JOIN
    country_populations cp ON u.country = cp.country
LEFT JOIN
    tweets t ON u.user_id = t.user_id
WHERE
    cp.population > 100000000;