 -- Tables: hospitals, clinics, long_term_care
 -- Technique: UNION (dialect: Mysql)

 SELECT type FROM hospitals WHERE location = 'Thành phố A'
 UNION
 SELECT type FROM clinics WHERE location = 'Thành phố A'
 UNION
 SELECT type FROM long_term_care WHERE location = 'Thành phố A';