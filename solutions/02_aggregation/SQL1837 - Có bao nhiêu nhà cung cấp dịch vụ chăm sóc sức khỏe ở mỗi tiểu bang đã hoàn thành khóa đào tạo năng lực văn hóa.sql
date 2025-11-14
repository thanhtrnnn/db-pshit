 -- Tables: healthcare_providers_training
 -- Technique: Group By (dialect: Mysql)
 SELECT
  state,
  COUNT(DISTINCT provider_id) AS providers_trained
 FROM
  healthcare_providers_training
 WHERE
  completed_training = TRUE
 GROUP BY
  state;