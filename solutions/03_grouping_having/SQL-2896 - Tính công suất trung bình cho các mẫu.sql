-- Tables: Vehicle_Types, Vehicle_Releases
-- Technique: JOIN, GROUP BY (dialect: mysql)

SELECT
    vt.Name AS type_name,
    AVG(vr.Horsepower) AS avg_hp
FROM
    Vehicle_Types AS vt
JOIN
    Vehicle_Releases AS vr
ON
    vt.Id = vr.Vehicle_Type_Id
WHERE
    vt.Name IN ('SUV', 'Truck')
    AND vr.Release_Date >= '2020-01-01'
    AND vr.Origin_Country IN ('USA', 'Germany')
GROUP BY
    vt.Name
ORDER BY
    avg_hp DESC;