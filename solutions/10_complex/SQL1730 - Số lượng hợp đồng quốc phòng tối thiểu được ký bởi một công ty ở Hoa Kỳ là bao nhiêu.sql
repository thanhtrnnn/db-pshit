SELECT
  MIN(contract_count)
FROM (
  SELECT
    dc_company,
    COUNT(dc_id) AS contract_count
  FROM
    defense_contracts
  WHERE
    dc_country = 'United States'
  GROUP BY
    dc_company
) AS company_contract_counts;