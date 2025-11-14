-- Tables: teacher_courses
-- Technique: Aggregate functions, Subquery (dialect: MySQL)

SELECT MAX(courses_count)
FROM (
    SELECT
        COUNT(course_id) AS courses_count
    FROM
        teacher_courses
    GROUP BY
        teacher_id, YEAR(completion_date)
) AS yearly_teacher_course_counts;