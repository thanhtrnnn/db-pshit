-- Tables: teacher_pd, student_mental_health
-- Technique: JOIN, GROUP BY (dialect: Mysql)

SELECT
  tp.tier,
  AVG(smh.mental_health_score) AS `AVG(smh.mental_health_score)`
FROM student_mental_health AS smh
JOIN teacher_pd AS tp
  ON smh.teacher_id = tp.teacher_id
GROUP BY
  tp.tier;
