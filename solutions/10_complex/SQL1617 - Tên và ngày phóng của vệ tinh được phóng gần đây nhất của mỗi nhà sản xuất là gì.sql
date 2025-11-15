select m.name, s.name, s.launch_date from
manufacturers m join satellites s 
on m.id = s.manufacturer_id
where launch_date = 
(
  select MAX(launch_date) from satellites
  where manufacturer_id = m.id
)
