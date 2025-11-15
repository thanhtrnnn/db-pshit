 -- Tables: products, ethical_certifications
 -- Technique: JOIN, Aggregate Function (dialect: Mysql)

 SELECT
  AVG(p.price) AS `AVG(p.price)`
 FROM
  products AS p
  INNER JOIN ethical_certifications AS ec ON p.id = ec.product_id;