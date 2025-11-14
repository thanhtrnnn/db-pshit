-- Tables: products, dispensaries, inventory
-- Technique: modification (dialect: Mysql)

INSERT INTO inventory (product_id, dispensary_id, price, quantity)
SELECT
    (SELECT product_id FROM products WHERE name = 'CBD Tincture' AND type = 'Relax'),
    (SELECT dispensary_id FROM dispensaries WHERE name = 'Healing Haven'),
    0.00, -- Default price, as not specified in the problem
    0     -- Default quantity, as not specified in the problem
;