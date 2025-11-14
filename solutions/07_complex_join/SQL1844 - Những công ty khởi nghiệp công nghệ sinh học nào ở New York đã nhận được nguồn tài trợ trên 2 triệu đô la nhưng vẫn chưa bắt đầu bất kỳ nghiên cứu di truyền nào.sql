SELECT b.startup_id
FROM biotech_startups AS b
JOIN funding AS f
  ON b.startup_id = f.startup_id
LEFT JOIN genetic_research AS gr
  ON b.startup_id = gr.startup_id
WHERE
  b.location = 'New York' AND f.amount > 2000000 AND gr.startup_id IS NULL;