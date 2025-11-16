 -- Tables: treatment_plants, wastewater, contamination_removal
 -- Technique: JOIN, Filtering, Aggregation (dialect: Mysql)

 SELECT
  MAX(cr.contamination_removed) AS max_contamination_removed
 FROM
  treatment_plants AS tp
 JOIN
  wastewater AS ww ON tp.id = ww.treatment_plant_id
 JOIN
  contamination_removal AS cr ON ww.id = cr.wastewater_id
 WHERE
  tp.plant_type = 'aerobic' AND YEAR(ww.treatment_date) = 2021;