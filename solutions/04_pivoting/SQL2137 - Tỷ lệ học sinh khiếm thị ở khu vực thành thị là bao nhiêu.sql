--- Tables: student_disabilities
--- Technique: Conditional Aggregation (dialect: Mysql)

SELECT
    'Urban' AS location,
    (SUM(CASE WHEN disability = 'Blindness' THEN count ELSE 0 END) * 100.0 / SUM(count)) 
    AS Urban_Percentage
FROM
    student_disabilities
WHERE
    location = 'Urban';