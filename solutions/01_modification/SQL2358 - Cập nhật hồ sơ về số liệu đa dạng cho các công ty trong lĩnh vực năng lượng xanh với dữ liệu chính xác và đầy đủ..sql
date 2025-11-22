-- Tables: diversity_metrics, company
-- Technique: UPDATE (dialect: MySQL)

UPDATE diversity_metrics dm
JOIN company c ON dm.company_id = c.id
SET
    dm.gender_distribution = '',
    dm.racial_distribution = ''
WHERE
    c.industry = 'Green Energy';