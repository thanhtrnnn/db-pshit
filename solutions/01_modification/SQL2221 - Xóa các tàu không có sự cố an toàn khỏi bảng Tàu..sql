-- Tables: Vessels, SafetyIncidents
-- Technique: DELETE (dialect: MySQL)
DELETE FROM Vessels
WHERE ID NOT IN (SELECT VesselID FROM SafetyIncidents);