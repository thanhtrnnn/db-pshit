-- Imported from batch1.md
-- Title: Average time of process per machine

SELECT machine_id,
    ROUND(
        SUM(CASE
                WHEN activity_type = 'end' THEN timestamp
                ELSE -timestamp
            END)
        / COUNT(DISTINCT process_id),
        3
    ) AS processing_time
FROM Activity
GROUP BY machine_id;
