-- Tables: hospitals, clinics
-- Technique: UNION ALL and Grouping (dialect: Mysql)

SELECT
    state AS `Tên tiểu bang`,
    type AS `Loại cơ sở`,
    SUM(hospital_count) AS `Số bệnh viện thuộc loại đó trong tiểu bang`,
    SUM(clinic_count) AS `Số phòng khám thuộc loại đó trong tiểu bang`
FROM
    (
        SELECT
            state,
            type,
            COUNT(id) AS hospital_count,
            0 AS clinic_count
        FROM
            hospitals
        GROUP BY
            state,
            type

        UNION ALL

        SELECT
            state,
            type,
            0 AS hospital_count,
            COUNT(id) AS clinic_count
        FROM
            clinics
        GROUP BY
            state,
            type
    ) AS combined_data
GROUP BY
    state,
    type
ORDER BY
    state, type;
