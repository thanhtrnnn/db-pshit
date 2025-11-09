-- SQL1639: Tàu (VesselName) có hàng ở cả Africa và Oceania
-- Bảng: Vessels(VesselID, VesselName), CargoLoads(LoadID, VesselID, LoadLocation, LoadDate)
-- Điều kiện: LoadLocation chứa 'Africa' và 'Oceania'
-- Output: VesselName

SELECT v.VesselName
FROM Vessels v
JOIN CargoLoads cl ON cl.VesselID = v.VesselID
WHERE cl.LoadLocation LIKE 'Africa%'
INTERSECT
SELECT v.VesselName
FROM Vessels v
JOIN CargoLoads cl ON cl.VesselID = v.VesselID
WHERE cl.LoadLocation LIKE 'Oceania%'
ORDER BY v.VesselName;

-- MySQL phiên bản không hỗ trợ INTERSECT: dùng GROUP BY/HAVING
-- SELECT v.VesselName
-- FROM Vessels v
-- JOIN CargoLoads cl ON cl.VesselID = v.VesselID
-- WHERE cl.LoadLocation LIKE 'Africa%' OR cl.LoadLocation LIKE 'Oceania%'
-- GROUP BY v.VesselName
-- HAVING COUNT(DISTINCT CASE
--            WHEN cl.LoadLocation LIKE 'Africa%' THEN 'Africa'
--            WHEN cl.LoadLocation LIKE 'Oceania%' THEN 'Oceania'
--        END) = 2
-- ORDER BY v.VesselName;
