--- Tables: chicago_prop, seattle_prop
--- Technique: Union All, Aggregation (dialect: MySQL)

SELECT
  COUNT(*) AS total_co_owned_properties
FROM (
  SELECT
    id
  FROM
    chicago_prop
  WHERE
    owner2 IS NOT NULL AND owner2 != ''
  UNION ALL
  SELECT
    id
  FROM
    seattle_prop
  WHERE
    owner2 IS NOT NULL AND owner2 != ''
) AS co_owned_properties;