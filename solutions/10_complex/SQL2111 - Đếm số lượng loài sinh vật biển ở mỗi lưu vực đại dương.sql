 -- Tables: species, ocean_basin
 -- Technique: INSERT with JOIN (dialect: MySQL)

INSERT INTO ocean_basin (id, name, species_count)
-- Bước 1: SELECT để tính toán toàn bộ dữ liệu cần thiết
SELECT
    ob.id,
    ob.name,
    COUNT(s.id) AS calculated_species_count
FROM
    ocean_basin AS ob
LEFT JOIN
    species AS s ON s.habitat LIKE CONCAT('%', ob.name, '%')
GROUP BY
    ob.id, ob.name
-- Bước 2: Chỉ định hành động khi có khóa trùng lặp
ON DUPLICATE KEY UPDATE
    species_count = VALUES(species_count);