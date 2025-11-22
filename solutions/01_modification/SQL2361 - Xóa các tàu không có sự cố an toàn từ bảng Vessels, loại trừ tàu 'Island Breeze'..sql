DELETE V
FROM Vessels AS V
LEFT JOIN SafetyIncidents AS SI ON V.ID = SI.VesselID
WHERE SI.ID IS NULL AND V.Name <> 'Island Breeze';