 -- Tables: CyberStrategy, Organization
 -- Technique: JOIN (dialect: Mysql)

 SELECT
  CS.name AS name,
  O.name AS organization_name,
  O.type AS type
 FROM
  CyberStrategy AS CS
 JOIN
  Organization AS O ON CS.organization_id = O.id;