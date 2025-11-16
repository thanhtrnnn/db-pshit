-- Tables: products, suppliers
-- Technique: UPDATE with JOIN (dialect: Mysql)
UPDATE suppliers s
JOIN (
    SELECT DISTINCT p.supplier_id
    FROM products p
    WHERE p.sourcing_country IN ('HighRiskCountry1', 'HighRiskCountry2', 'HighRiskCountry3') -- Placeholder: Replace with the actual list of high-risk countries
) AS high_risk_source_suppliers ON s.supplier_id = high_risk_source_suppliers.supplier_id
SET s.ethical_rating = 1; -- Example update: Setting ethical_rating to 1 (lowest) due to high-risk sourcing