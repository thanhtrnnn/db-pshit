CREATE TABLE teacher_pd (
  teacher_id INT,
  tier INT
);

CREATE TABLE student_mental_health (
  student_id INT,
  mental_health_score INT,
  teacher_id INT
);

INSERT INTO teacher_pd (teacher_id, tier) VALUES
(101, 1),
(102, 2),
(103, 1),
(104, 3),
(105, 2);

INSERT INTO student_mental_health (student_id, mental_health_score, teacher_id) VALUES
(1, 75, 101),
(2, 80, 101),
(3, 60, 102),
(4, 85, 103),
(5, 70, 102),
(6, 90, 104),
(7, 65, 105),
(8, 72, 104);

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
