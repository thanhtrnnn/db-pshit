-- Imported from batch1.md
-- Title: Number of Unique Subject taught by each teacher

SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
