CREATE TABLE vessels (
  id INT,
  name TEXT,
  type TEXT,
  safety_record TEXT
);

CREATE TABLE incidents (
  id INT,
  vessel_id INT,
  location TEXT,
  incident_date DATE
);

-- Tables: vessels, incidents
-- Technique: JOIN, UPDATE (dialect: Mysql)
UPDATE vessels v
JOIN incidents i ON v.id = i.vessel_id
SET v.safety_record = 'Requires review due to incident in Biển Đông'
WHERE i.location = 'Biển Đông';