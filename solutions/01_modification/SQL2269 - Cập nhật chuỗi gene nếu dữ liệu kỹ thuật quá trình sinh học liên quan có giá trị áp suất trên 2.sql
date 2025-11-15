-- Tables: genetic_data, bioprocess_data
-- Technique: JOIN, UPDATE (dialect: Mysql)

UPDATE genetic_data gd
JOIN bioprocess_data bd ON gd.sample_id = bd.sample_id
SET gd.gene_sequence = 'ATGCGT...'
WHERE bd.pressure > 2;