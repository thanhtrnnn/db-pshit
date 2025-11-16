 -- Tables: Donations, VolunteerHours
-- Technique: UNION ALL (dialect: Mysql)

SELECT
    'Donations' AS TableName,
    ProgramID,
    SUM(DonationAmount) AS TotalDonation
FROM
    Donations
GROUP BY
    ProgramID

UNION ALL

SELECT
    'VolunteerHours' AS TableName,
    ProgramID,
    SUM(VolunteerHours) AS TotalDonation
FROM
    VolunteerHours
GROUP BY
    ProgramID;