SELECT 
    COUNT(DISTINCT c.founder_gender) AS unique_founders,
    SUM(f.amount) AS total_funding
FROM companies c
LEFT JOIN funding f 
    ON c.id = f.company_id
WHERE c.industry = 'Energy'
  AND c.founded_date < '2015-01-01';