-- Tables: sensor_data
-- Technique: UPDATE (dialect: MySQL)

UPDATE sensor_data
SET temperature = @new_temperature_value
WHERE sensor_id = @specific_sensor_id
  AND temperature > @threshold_temperature;