DELETE s
FROM
    shipment AS s
JOIN
    warehouse AS w ON s.warehouse_id = w.id
JOIN
    carrier AS c ON s.carrier_id = c.id
WHERE
    w.city = 'Rio de Janeiro'
    AND c.name = 'Brazil'
    AND s.shipped_date < '2022-02-01';