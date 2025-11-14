--- Tables: vegetarian_menus
--- Technique: subquery (dialect: Sql Server)

SELECT
  menu_name,
  price
FROM
  vegetarian_menus
WHERE
  menu_type = 'Entree' AND price < (
    SELECT
      MAX(price)
    FROM
      vegetarian_menus
  );