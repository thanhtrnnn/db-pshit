--- Tables: professors
--- Technique: Filtering (dialect: Mysql)

SELECT
  name,
  research_interest
FROM professors
WHERE
  gender = 'Female' AND publication_field = 'Artificial Intelligence';