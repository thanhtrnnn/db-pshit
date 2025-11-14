WITH all_facilities AS (
    -- Bước 1: Hợp nhất dữ liệu từ hospitals và clinics
    SELECT 
        territory, 
        'hospital' AS facility_type,
        has_helipad
    FROM 
        hospitals
    
    UNION ALL
    
    SELECT 
        territory, 
        'clinic' AS facility_type,
        0 AS has_helipad -- Clinics don't have helipads, so we add a placeholder '0'
    FROM 
        clinics
)
-- Bước 2: Nhóm và đếm từ dữ liệu đã hợp nhất
SELECT
    territory,
    COUNT(CASE WHEN facility_type = 'hospital' THEN 1 END) AS num_hospitals,
    COUNT(CASE WHEN facility_type = 'clinic' THEN 1 END) AS num_clinics,
    SUM(has_helipad) AS num_hospitals_with_helipad
FROM
    all_facilities
GROUP BY
    territory
ORDER BY
    territory;