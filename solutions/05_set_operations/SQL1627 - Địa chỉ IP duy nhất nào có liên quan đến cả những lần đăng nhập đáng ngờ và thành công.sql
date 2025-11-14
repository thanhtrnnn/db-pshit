--- Tables: login_attempts
--- Technique: set_operations (dialect: Sql Server)

SELECT DISTINCT ip_address
FROM login_attempts
WHERE login_status = 'successful'
INTERSECT
SELECT DISTINCT ip_address
FROM login_attempts
WHERE login_status = 'suspicious';