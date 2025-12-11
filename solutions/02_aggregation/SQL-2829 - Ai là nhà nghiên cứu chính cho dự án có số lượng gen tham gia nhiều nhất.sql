SELECT T1.lead_researcher
FROM research AS T1
INNER JOIN gene AS T2
  ON T1.id = T2.research_id
GROUP BY
  T1.lead_researcher
ORDER BY
  COUNT(T2.id) DESC
LIMIT 1;