--- Tables: hospitals
--- Technique: UPDATE (dialect: Mysql)
UPDATE hospitals
SET num_icu_beds = ROUND(num_icu_beds * 1.10)
WHERE location = 'Urban'
  AND state IN ('Illinois', 'Michigan');