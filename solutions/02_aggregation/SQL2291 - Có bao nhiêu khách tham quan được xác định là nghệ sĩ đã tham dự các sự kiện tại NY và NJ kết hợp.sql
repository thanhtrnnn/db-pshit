-- Tables: Events
-- Technique: Aggregate function (dialect: MySQL)

SELECT
    SUM(Attendance) AS total_attendance
FROM
    Events
WHERE
    EventLocation LIKE '%Artist%'
    AND (EventLocation LIKE '%NY%' OR EventLocation LIKE '%NJ%');