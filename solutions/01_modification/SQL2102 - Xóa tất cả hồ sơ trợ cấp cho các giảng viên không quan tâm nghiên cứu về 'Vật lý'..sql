DELETE FROM grants
WHERE faculty_name IN (
    SELECT name
    FROM faculty
    WHERE research_interest NOT LIKE '%Vật lý%'
);