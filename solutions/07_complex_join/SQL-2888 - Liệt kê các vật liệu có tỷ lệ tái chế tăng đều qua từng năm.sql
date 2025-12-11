SELECT T1.material
FROM recycling_rates AS T1
INNER JOIN recycling_rates AS T2
  ON T1.material = T2.material AND T1.year = 2017 AND T2.year = 2018
INNER JOIN recycling_rates AS T3
  ON T1.material = T3.material AND T1.year = 2017 AND T3.year = 2019
WHERE
  T1.recycling_rate < T2.recycling_rate AND T2.recycling_rate < T3.recycling_rate
ORDER BY
  T1.material;