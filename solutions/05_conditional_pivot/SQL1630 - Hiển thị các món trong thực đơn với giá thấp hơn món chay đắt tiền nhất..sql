-- SQL1630: Các món Entree có giá thấp hơn món Entree đắt nhất
-- Bảng: vegetarian_menus(menu_id, menu_name, menu_type, price)
-- Output: menu_name | price (chỉ Entree với price < MAX(price) của Entree)

SELECT menu_name, price
FROM vegetarian_menus
WHERE menu_type = 'Entree'
  AND price < (
      SELECT MAX(price)
      FROM vegetarian_menus
      WHERE menu_type = 'Entree'
  )
ORDER BY menu_name;
