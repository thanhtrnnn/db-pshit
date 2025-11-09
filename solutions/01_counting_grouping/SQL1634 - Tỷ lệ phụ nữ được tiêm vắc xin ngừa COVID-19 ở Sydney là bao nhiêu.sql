-- SQL1634: Tỷ lệ (%) số buổi tiêm chủng của bệnh nhân nữ tại Sydney
-- Bảng: Vaccinations(VaccinationID, PatientID, Gender, VaccineType, Date, City)
-- Output: Female_Percentage_Sydney(%)

SELECT ROUND(
    100.0 * SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END)
          / NULLIF(COUNT(*), 0)
    , 2
) AS "Female_Percentage_Sydney(%)"
FROM Vaccinations
WHERE City = 'Sydney';

