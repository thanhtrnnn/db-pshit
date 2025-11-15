SELECT SUM(trials) AS `SUM(trials)`
FROM clinical_trials
WHERE drug_name = 'DrugB'
  AND region = 'Europe'
  AND year BETWEEN 2018 AND 2020;