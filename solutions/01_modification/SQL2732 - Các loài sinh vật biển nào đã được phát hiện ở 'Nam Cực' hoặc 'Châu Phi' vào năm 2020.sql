CREATE TABLE Species_2 (
  id INT,
  name VARCHAR(255),
  region VARCHAR(255),
  year INT
);

INSERT INTO Species_2 (id, name, region, year) VALUES
(1, 'Cá voi xanh', 'Nam Cực', 2020),
(2, 'Sứa biển', 'Châu Phi', 2020),
(3, 'Cá mập trắng', 'Đại Tây Dương', 2020),
(4, 'Chim cánh cụt', 'Nam Cực', 2019),
(5, 'Hải cẩu', 'Châu Phi', 2021),
(6, 'Rùa biển', 'Nam Cực', 2020),
(7, 'Sao biển', 'Châu Phi', 2020);

-- Tables: Species_2
-- Technique: Filtering (dialect: Mysql)
SELECT
  name
FROM Species_2
WHERE
  (region = 'Nam Cực' OR region = 'Châu Phi') AND year = 2020;