--- Tables: FINANCIAL_CAPABILITY_PROGRAMS
--- Technique: Group By, Subquery (dialect: Mysql)

SELECT
    BANK_NAME,
    COUNT(PROGRAM_NAME) AS TOTAL_PROGRAMS
FROM
    FINANCIAL_CAPABILITY_PROGRAMS
WHERE
    START_DATE >= '2022-01-01' AND START_DATE < '2022-04-01'
GROUP BY
    BANK_NAME
HAVING
    TOTAL_PROGRAMS = (
        SELECT
            MAX(sub_total_programs)
        FROM (
            SELECT
                COUNT(PROGRAM_NAME) AS sub_total_programs
            FROM
                FINANCIAL_CAPABILITY_PROGRAMS
            WHERE
                START_DATE >= '2022-01-01' AND START_DATE < '2022-04-01'
            GROUP BY
                BANK_NAME
        ) AS QuarterlyProgramCounts
    )
ORDER BY
    TOTAL_PROGRAMS DESC;