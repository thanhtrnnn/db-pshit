-- Tables: SafetyRecords, Vessel
-- Technique: UPDATE with JOIN (dialect: Mysql)

UPDATE SafetyRecords sr
JOIN Vessel v ON sr.VesselId = v.Id
SET sr.IsCompliant = 'Yes'
WHERE v.MaxCapacity < 5000;