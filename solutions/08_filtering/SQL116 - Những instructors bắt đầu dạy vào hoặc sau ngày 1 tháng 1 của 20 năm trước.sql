select username,fname,lname,started_on 
from Instructor 
where Str_to_date(started_on,'%Y+20-%m-%d') <= current_time;