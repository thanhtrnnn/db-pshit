-- Tables: seoul_bikeshare, tokyo_bikeshare
-- Technique: Subquery, Aggregation (dialect: Mysql)
SELECT
    ABS(
        (SELECT COUNT(*) FROM seoul_bikeshare) -
        (SELECT COUNT(*) FROM tokyo_bikeshare)
    ) AS difference_in_trips;