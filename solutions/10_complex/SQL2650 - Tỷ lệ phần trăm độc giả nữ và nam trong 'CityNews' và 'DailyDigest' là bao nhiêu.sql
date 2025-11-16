--- Tables: CityNews, DailyDigest
--- Technique: UNION ALL, Conditional Aggregation (dialect: Mysql)

SELECT
    'CityNews' AS newspaper,
    SUM(CASE WHEN reader_gender = 'Female' THEN 1 ELSE 0 END) AS female_readers,
    SUM(CASE WHEN reader_gender = 'Male' THEN 1 ELSE 0 END) AS male_readers
FROM
    CityNews

UNION ALL

SELECT
    'DailyDigest' AS newspaper,
    SUM(CASE WHEN reader_gender = 'Female' THEN 1 ELSE 0 END) AS female_readers,
    SUM(CASE WHEN reader_gender = 'Male' THEN 1 ELSE 0 END) AS male_readers
FROM
    DailyDigest;