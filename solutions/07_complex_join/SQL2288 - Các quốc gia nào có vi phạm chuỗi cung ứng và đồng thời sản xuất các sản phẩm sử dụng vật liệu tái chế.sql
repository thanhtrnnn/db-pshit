select 
    s.country 
from SupplyChainViolations s 
join Products p 
on p.country = s.country
join ProductTransparency pt 
on p.product_id = pt.product_id 
where s.num_violations > 0 
and pt.recycled_materials = true