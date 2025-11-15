SELECT
  COUNT(w.id)
FROM wildlife AS w
JOIN forests AS f
  ON w.forest_id = f.id
WHERE
  f.is_protected = TRUE;