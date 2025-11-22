--- Tables: Suppliers, Garment_Suppliers, Garments
--- Technique: Joins, Aggregation (dialect: Mysql)
--- TLE 2ms

select
  s.supplier_name
  , count(gs.garment_id) as garments_supplied
from Suppliers s 
join Garment_Suppliers gs
on s.supplier_id = gs.supplier_id
join Garments g 
on gs.garment_id = g.garment_id
where g.collection_name = 'Spring 2023'
group by s.supplier_name
order by garments_supplied desc