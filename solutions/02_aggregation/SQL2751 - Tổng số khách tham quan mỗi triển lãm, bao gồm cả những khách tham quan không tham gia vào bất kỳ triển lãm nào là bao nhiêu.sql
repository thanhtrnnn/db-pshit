select
    Name
    , count(VisitorID) as TotalVisitors
from Exhibitions e 
left join Visitors v 
on e.ExhibitionID = v.ExhibitionID 
group by Name