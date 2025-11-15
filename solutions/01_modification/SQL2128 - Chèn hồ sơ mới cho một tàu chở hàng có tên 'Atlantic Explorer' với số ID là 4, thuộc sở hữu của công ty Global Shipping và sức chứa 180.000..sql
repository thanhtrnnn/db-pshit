CREATE TABLE cargo_ships (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    owner_id INT
);

CREATE TABLE owners (
    owner_id INT PRIMARY KEY,
    owner_name VARCHAR(255)
);

-- Tables: cargo_ships, owners
-- Technique: INSERT (dialect: Mysql)

INSERT INTO cargo_ships (id, name, capacity, owner_id)
VALUES (4, 'Atlantic Explorer', 180000, (SELECT owner_id FROM owners WHERE owner_name = 'Global Shipping'));