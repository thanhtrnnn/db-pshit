--- Tables: CommunityEngagement
--- Technique: Filtering, Aggregation (dialect: Mysql)

SELECT
    SUM(Budget) AS Total_Budget
FROM
    CommunityEngagement
WHERE
    Country IN (
        'Australia',
        'Fiji',
        'Kiribati',
        'Marshall Islands',
        'Micronesia',
        'Nauru',
        'New Zealand',
        'Palau',
        'Papua New Guinea',
        'Samoa',
        'Solomon Islands',
        'Tonga',
        'Tuvalu',
        'Vanuatu'
    );