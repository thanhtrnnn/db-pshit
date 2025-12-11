SELECT
  Origin_Country,
  COUNT(Id) AS model_count
FROM Vehicle_Releases
WHERE
  Horsepower BETWEEN 150 AND 350
  AND Release_Date > '2018-12-31'
GROUP BY
  Origin_Country
ORDER BY
  model_count DESC;