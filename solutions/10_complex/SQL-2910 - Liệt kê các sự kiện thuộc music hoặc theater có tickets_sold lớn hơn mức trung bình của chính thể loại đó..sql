--- Tables: events
--- Technique: JOIN (dialect: MySQL)

SELECT
    e.name,
    e.category,
    e.tickets_sold
FROM
    events AS e
JOIN
    (
        SELECT
            category,
            AVG(tickets_sold) AS avg_tickets_sold
        FROM
            events
        WHERE
            category IN ('music', 'theater')
        GROUP BY
            category
    ) AS avg_category_sales
ON
    e.category = avg_category_sales.category
WHERE
    e.category IN ('music', 'theater')
    AND e.tickets_sold > avg_category_sales.avg_tickets_sold
ORDER BY
    e.tickets_sold DESC;