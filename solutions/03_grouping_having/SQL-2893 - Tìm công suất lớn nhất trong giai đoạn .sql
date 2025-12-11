SELECT
  vt.Name AS type_name,
  MAX(vr.Horsepower) AS max_hp
FROM Vehicle_Types AS vt
JOIN Vehicle_Releases AS vr
  ON vt.Id = vr.Vehicle_Type_Id
WHERE
  vr.Release_Date BETWEEN '2021-01-01' AND '2022-12-31'
GROUP BY
  vt.Name
ORDER BY
  max_hp DESC;