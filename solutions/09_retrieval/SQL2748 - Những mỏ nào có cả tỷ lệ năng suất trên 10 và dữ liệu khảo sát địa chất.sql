-- Tables: mine_productivity, geology_survey
-- Technique: JOIN (dialect: Mysql)
SELECT DISTINCT
    mp.mine_name
FROM
    mine_productivity AS mp
JOIN
    geology_survey AS gs ON mp.mine_name = gs.mine_name
WHERE
    mp.productivity > 10;