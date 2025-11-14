WITH RankedSatellites AS (
    -- Bước 1 & 2: Kết hợp bảng và xếp hạng vệ tinh cho mỗi nhà sản xuất
    SELECT
        CAST(m.name AS VARCHAR(MAX)) AS manufacturer,
        CAST(s.name AS VARCHAR(MAX)) AS satellite,
        s.launch_date,
        ROW_NUMBER() OVER(PARTITION BY s.manufacturer_id ORDER BY s.launch_date DESC) AS rn
    FROM
        manufacturers AS m
    JOIN
        satellites AS s ON m.id = s.manufacturer_id
)
-- Bước 3: Lọc ra vệ tinh có hạng 1 (gần nhất) của mỗi nhà sản xuất
SELECT
    manufacturer,
    satellite,
    launch_date
FROM
    RankedSatellites
WHERE
    rn = 1
ORDER BY
    manufacturer;