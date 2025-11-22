-- Tables: Peacekeeping_Operations, Defense_Diplomacy
-- Technique: Subqueries (dialect: Mysql)

SELECT
  (SELECT COUNT(*) FROM Peacekeeping_Operations) AS Total_Peacekeeping_Operations,
  (SELECT COUNT(*) FROM Defense_Diplomacy) AS Total_Defense_Diplomacy;