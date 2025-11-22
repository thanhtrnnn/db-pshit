-- Tables: Members, Workouts
-- Technique: DELETE with subquery (dialect: Mysql)

DELETE FROM Workouts
WHERE MemberID IN (
    SELECT MemberID
    FROM Members
    WHERE DateJoined > '2022-03-31'
);