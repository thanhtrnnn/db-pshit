-- Tables: ResearchProject, ExcavationSite, FundingSource
-- Technique: Joins, Filtering (dialect: MySQL)

SELECT
    RP.ProjectName,
    ES.SiteName,
    FS.SourceName,
    FS.Amount
FROM
    ResearchProject AS RP
JOIN
    ExcavationSite AS ES ON RP.SiteID = ES.SiteID
JOIN
    FundingSource AS FS ON RP.ProjectID = FS.ProjectID
WHERE
    ES.Country = 'Egypt'
    AND RP.StartDate <= CURDATE()
    AND RP.EndDate > CURDATE();