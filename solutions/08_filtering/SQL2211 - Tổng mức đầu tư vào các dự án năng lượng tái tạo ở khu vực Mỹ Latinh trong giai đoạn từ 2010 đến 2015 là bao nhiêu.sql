SELECT SUM(investment)
FROM renewable_energy
WHERE
    region LIKE 'Latin%'
    AND year BETWEEN 2010 AND 2015;