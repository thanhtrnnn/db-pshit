-- Tables: Volunteers
-- Technique: Group By, Filtering (dialect: Mysql)

select
    program_category
    , count(distinct volunteer_id) as total_volunteers
from Volunteers
where volunteer_date between '2022-01-01' and '2022-04-01'
group by program_category;