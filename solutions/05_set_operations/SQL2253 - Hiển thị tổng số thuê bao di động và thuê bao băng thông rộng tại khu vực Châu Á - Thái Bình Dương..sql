 -- Tables: mobile_subscribers, broadband_subscribers
 -- Technique: UNION ALL (dialect: Mysql)

 SELECT COUNT(*) AS `COUNT(*)`
 FROM mobile_subscribers
 WHERE region = 'Asia-Pacific'

 UNION ALL

 SELECT COUNT(*) AS `COUNT(*)`
 FROM broadband_subscribers
 WHERE region = 'Asia-Pacific';