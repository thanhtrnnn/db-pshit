--- Tables: museums, art_collections, community_programs
--- Technique: Subqueries (dialect: Mysql)

SELECT
    'United States' AS location,
    COALESCE((SELECT SUM(ac.revenue)
              FROM art_collections ac
              JOIN museums m ON ac.museum_id = m.id
              WHERE m.location LIKE '%United States%' AND ac.type = 'Permanent'), 0.0) AS total_collection_revenue,
    COALESCE((SELECT SUM(cp.revenue)
              FROM community_programs cp
              JOIN museums m ON cp.museum_id = m.id
              WHERE m.location LIKE '%United States%' AND cp.type = 'Art'), 0.0) AS total_program_revenue;