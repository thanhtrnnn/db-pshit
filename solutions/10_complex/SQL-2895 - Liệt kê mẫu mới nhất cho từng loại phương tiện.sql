-- Tables: Vehicle_Types, Vehicle_Releases
-- Technique: Window functions (dialect: mysql)

SELECT
    vt.Name AS type_name,
    vr.Name AS model_name,
    vr.Release_Date AS release_date
FROM
    Vehicle_Types vt
JOIN
    Vehicle_Releases vr ON vt.Id = vr.Vehicle_Type_Id
WHERE (
    vt.Id,
    vr.Release_Date
) IN (
    SELECT
        Vehicle_Type_Id,
        MAX(Release_Date)
    FROM
        Vehicle_Releases
    GROUP BY
        Vehicle_Type_Id
)
ORDER BY
    type_name,
    model_name;