-- Tables: Vehicle_Types, Vehicle_Releases
-- Technique: JOIN, Aggregate (dialect: Mysql)

SELECT
    MAX(vr.Horsepower) AS horsepower
FROM
    Vehicle_Releases AS vr
JOIN
    Vehicle_Types AS vt
ON
    vr.Vehicle_Type_Id = vt.Id
WHERE
    vt.Name = 'Sedan' AND vr.Release_Date >= '2020-01-01';