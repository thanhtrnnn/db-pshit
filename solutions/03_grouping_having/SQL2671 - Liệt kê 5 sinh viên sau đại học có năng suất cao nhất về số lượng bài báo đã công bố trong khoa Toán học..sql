SELECT
  gs.name,
  COUNT(p.id) AS paper_count
FROM graduate_students AS gs
JOIN publications AS p
  ON gs.id = p.author_id
WHERE
  gs.department = 'Toán học'
GROUP BY
  gs.name
ORDER BY
  paper_count DESC
LIMIT 5;