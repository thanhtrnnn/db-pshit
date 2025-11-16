SELECT
    IFNULL(location, 'Total') AS Ocean,
    COUNT(DISTINCT species_name) AS SpeciesCount
FROM
    oceanography
GROUP BY
    location WITH ROLLUP;