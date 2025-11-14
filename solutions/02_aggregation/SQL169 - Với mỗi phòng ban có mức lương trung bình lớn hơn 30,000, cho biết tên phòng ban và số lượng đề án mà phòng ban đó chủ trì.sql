select company_name from companies group by company_name having count(distinct company_name) > 1
