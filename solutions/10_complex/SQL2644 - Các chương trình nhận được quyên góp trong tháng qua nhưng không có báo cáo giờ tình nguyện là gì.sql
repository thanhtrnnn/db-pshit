-- Tables: Programs, Donations, VolunteerHours
-- Technique: LEFT JOIN (dialect: MySQL)

SELECT P.ProgramName
FROM Programs AS P
INNER JOIN (
    SELECT DISTINCT ProgramID
    FROM Donations
    WHERE DonationDate >= CURDATE() - INTERVAL 1 MONTH
) AS RecentDonatedPrograms ON P.ProgramID = RecentDonatedPrograms.ProgramID
LEFT JOIN VolunteerHours AS VH ON P.ProgramID = VH.ProgramID
WHERE VH.ProgramID IS NULL;