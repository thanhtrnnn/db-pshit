-- Tables: sensor_data
-- Technique: modification (dialect: Mysql)

UPDATE sensor_data
SET temperature = @new_temperature_value
WHERE sensor_id = @sensor_id_to_update
  AND @new_temperature_value > temperature;