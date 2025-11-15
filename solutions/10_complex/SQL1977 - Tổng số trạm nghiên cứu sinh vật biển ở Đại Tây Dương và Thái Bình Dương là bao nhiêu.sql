--- Tables: atlantic_ocean, pacific_ocean
--- Technique: Subquery (dialect: Mysql)
SELECT
    (SELECT COUNT(*) FROM atlantic_ocean) + (SELECT COUNT(*) FROM pacific_ocean) AS total_stations;