SELECT
    name
FROM
    countries
WHERE
    num_orgs = (SELECT MIN(num_orgs) FROM countries);