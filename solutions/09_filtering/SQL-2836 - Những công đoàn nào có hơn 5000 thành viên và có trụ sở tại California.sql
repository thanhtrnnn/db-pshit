-- Tables: Union_Info
-- Technique: filtering (dialect: Mysql)

SELECT
    id,
    union_name,
    state,
    member_count
FROM
    Union_Info
WHERE
    member_count > 5000 AND state = 'California';