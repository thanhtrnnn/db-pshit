-- Tables: user_ratings, show_views
-- Technique: UNION, GROUP BY (dialect: MySQL)

SELECT
  month_number,
  COUNT(DISTINCT user_id) AS unique_users_count
FROM
  (
    SELECT
      user_id,
      MONTH(rating_date) AS month_number
    FROM
      user_ratings
    WHERE
      YEAR(rating_date) = 2019
    UNION ALL
    SELECT
      user_id,
      MONTH(views_date) AS month_number
    FROM
      show_views
    WHERE
      YEAR(views_date) = 2019
  ) AS combined_activities
GROUP BY
  month_number
ORDER BY
  month_number;