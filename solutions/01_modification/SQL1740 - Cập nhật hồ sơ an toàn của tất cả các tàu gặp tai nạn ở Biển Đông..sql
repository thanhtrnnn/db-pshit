-- Tables: vessels, incidents
-- Technique: JOIN, UPDATE (dialect: Mysql)
-- unclear problem statement

Update vessels
Set safety_record = case when id in (
    select vessel_id
    from incidents
    where location = N'South China Sea'
) then N'Không an toàn' else N'An toàn'
End;