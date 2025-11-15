--- Tables: marine_protected_areas
--- Technique: Subquery (dialect: Mysql)
SELECT
    (SELECT MAX(depth) FROM marine_protected_areas WHERE ocean = 'Arctic Ocean') AS max_depth,
    (SELECT MIN(depth) FROM marine_protected_areas WHERE ocean = 'Southern Ocean') AS min_depth;