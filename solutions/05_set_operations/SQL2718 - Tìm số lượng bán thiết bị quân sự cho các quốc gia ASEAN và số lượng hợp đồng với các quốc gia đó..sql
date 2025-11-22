 -- Tables: MilitaryEquipmentSales, Contracts
 -- Technique: UNION ALL (dialect: Mysql)
 SELECT COUNT(*) AS `COUNT(*)`
 FROM MilitaryEquipmentSales
 WHERE customer_country IN (
  'Brunei', 'Cambodia', 'Indonesia', 'Laos', 'Malaysia', 'Myanmar',
  'Philippines', 'Singapore', 'Thailand', 'Vietnam'
 )
 UNION ALL
 SELECT COUNT(*) AS `COUNT(*)`
 FROM Contracts
 WHERE customer_country IN (
  'Brunei', 'Cambodia', 'Indonesia', 'Laos', 'Malaysia', 'Myanmar',
  'Philippines', 'Singapore', 'Thailand', 'Vietnam'
 );