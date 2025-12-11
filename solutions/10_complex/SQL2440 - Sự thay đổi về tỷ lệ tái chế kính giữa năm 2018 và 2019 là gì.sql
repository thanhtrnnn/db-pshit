SELECT
  (
    (SELECT recycling_rate FROM recycling_rates WHERE material = 'glass' AND year = 2019) -
    (SELECT recycling_rate FROM recycling_rates WHERE material = 'glass' AND year = 2018)
  ) AS rate_difference;