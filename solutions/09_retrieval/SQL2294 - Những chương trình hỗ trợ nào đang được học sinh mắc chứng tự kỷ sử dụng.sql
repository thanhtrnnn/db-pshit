-- Tables: SupportPrograms, StudentDisabilities, StudentPrograms
-- Technique: Multiple JOINs (dialect: MySQL)

SELECT DISTINCT
    sp.ProgramName,
    sp.ProgramType
FROM
    SupportPrograms AS sp
JOIN
    StudentPrograms AS stp ON sp.ProgramID = stp.ProgramID
JOIN
    StudentDisabilities AS std ON stp.StudentID = std.StudentID
WHERE
    std.DisabilityType = 'Autism';