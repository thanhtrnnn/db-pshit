-- Tables: nytimes, wa_post
-- Technique: Recursive CTE (dialect: MySQL)

WITH RECURSIVE AllRelevantTags AS (
    SELECT tags
    FROM nytimes
    WHERE content LIKE '%biến đổi khí hậu%' OR title LIKE '%biến đổi khí hậu%'
    UNION ALL
    SELECT tags
    FROM wa_post
    WHERE content LIKE '%biến đổi khí hậu%' OR title LIKE '%biến đổi khí hậu%'
),
SplitTags AS (
    SELECT
        TRIM(SUBSTRING_INDEX(t.tags, ',', 1)) AS tag,
        CASE WHEN LOCATE(',', t.tags) > 0 THEN SUBSTRING(t.tags, LOCATE(',', t.tags) + 1) ELSE '' END AS remaining_tags
    FROM AllRelevantTags AS t
    WHERE t.tags IS NOT NULL AND t.tags != ''

    UNION ALL

    SELECT
        TRIM(SUBSTRING_INDEX(st.remaining_tags, ',', 1)) AS tag,
        CASE WHEN LOCATE(',', st.remaining_tags) > 0 THEN SUBSTRING(st.remaining_tags, LOCATE(',', st.remaining_tags) + 1) ELSE '' END AS remaining_tags
    FROM SplitTags AS st
    WHERE st.remaining_tags != ''
)
SELECT DISTINCT tag
FROM SplitTags
WHERE tag IS NOT NULL AND tag != ''
ORDER BY tag;