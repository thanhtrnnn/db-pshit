DELETE s
FROM shipment AS s
JOIN warehouse AS w ON s.warehouse_id = w.id
WHERE w.name = 'Rio de Janeiro'
  AND w.city = 'Brazil'
  AND s.shipped_date < '2022-02-01';