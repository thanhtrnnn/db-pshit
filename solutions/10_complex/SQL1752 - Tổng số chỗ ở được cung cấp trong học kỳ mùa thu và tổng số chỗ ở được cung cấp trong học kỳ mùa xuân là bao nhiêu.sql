--- Tables: FallAccommodations, SpringAccommodations
--- Technique: Aggregate Functions (dialect: MySQL)

SELECT
    (SELECT COUNT(*) FROM FallAccommodations) AS TotalFallAccommodations,
    (SELECT COUNT(*) FROM SpringAccommodations) AS TotalSpringAccommodations;