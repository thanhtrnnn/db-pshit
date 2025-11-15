 -- Tables: habitats, habitat_preservation, education_programs
 -- Technique: JOIN, GROUP BY (dialect: MySQL)

 SELECT
  h.habitat_type AS Habitat_Type,
  COUNT(ep.program_id) AS Number_of_Programs
 FROM
  habitats AS h
 INNER JOIN
  habitat_preservation AS hp
  ON h.habitat_id = hp.habitat_id
 INNER JOIN
  education_programs AS ep
  ON hp.program_id = ep.program_id
 GROUP BY
  h.habitat_type
 ORDER BY
  h.habitat_type;