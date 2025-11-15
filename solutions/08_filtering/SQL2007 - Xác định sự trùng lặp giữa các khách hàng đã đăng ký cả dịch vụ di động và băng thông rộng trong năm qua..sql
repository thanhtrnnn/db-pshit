--- Tables: mobile_subscribers, broadband_subscribers
--- Technique: INNER JOIN (dialect: Mysql)

SELECT
    ms.subscriber_id
FROM
    mobile_subscribers ms
INNER JOIN
    broadband_subscribers bs ON ms.subscriber_id = bs.subscriber_id
WHERE
    ms.joined_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    AND bs.joined_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);