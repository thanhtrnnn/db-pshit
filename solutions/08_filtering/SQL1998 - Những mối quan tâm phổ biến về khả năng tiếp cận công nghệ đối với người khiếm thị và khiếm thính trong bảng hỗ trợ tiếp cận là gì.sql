-- Tables: accessibility
-- Technique: Filtering (dialect: MySQL)

SELECT DISTINCT
    concern
FROM
    accessibility
WHERE
    disability = 'people with visual impairments' OR disability = 'people with hearing impairments';