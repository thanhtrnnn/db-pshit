 -- Tables: armory, naval_base
 -- Technique: UNION ALL (dialect: Mysql)

SELECT COUNT(*) FROM armory
UNION ALL
SELECT COUNT(*) FROM naval_base;