 -- Tables: tech_accessibility_orgs, papers
 -- Technique: JOIN, DISTINCT (dialect: Mysql)

 SELECT DISTINCT
  tao.name
 FROM
  tech_accessibility_orgs AS tao
 JOIN
  papers AS p
 ON
  tao.id = p.org_id;