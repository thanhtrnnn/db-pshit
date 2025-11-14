--- Tables: mobile_subscribers, broadband_subscribers
--- Technique: set_operations (dialect: Sql Server)

SELECT COUNT(*) AS "COUNT(*)"
FROM mobile_subscribers

UNION ALL

SELECT COUNT(*) AS "COUNT(*)"
FROM broadband_subscribers;
