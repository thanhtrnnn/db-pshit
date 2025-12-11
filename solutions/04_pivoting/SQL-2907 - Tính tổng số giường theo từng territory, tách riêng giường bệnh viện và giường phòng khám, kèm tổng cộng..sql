json
{
  "sql": "```sql
-- Tables: hospitals, clinics
-- Technique: UNION ALL, Conditional Aggregation (dialect: Mysql)

SELECT
    t.territory,
    SUM(CASE WHEN t.source = 'hospital' THEN t.num_beds ELSE 0 END) AS total_hospital_beds,
    SUM(CASE WHEN t.source = 'clinic' THEN t.num_beds ELSE 0 END) AS total_clinic_beds,
    SUM(t.num_beds) AS total_beds
FROM
    (SELECT territory, num_beds, 'hospital' AS source FROM hospitals
     UNION ALL
     SELECT territory, num_beds, 'clinic' AS source FROM clinics) AS t
GROUP BY
    t.territory
ORDER BY
    total_beds DESC;
```",
  "reasoning": "The problem asks to calculate the total number of beds per territory, separating hospital beds and clinic beds, and providing a grand total for all beds in that territory. The results should be ordered by the total number of beds in descending order. The database type is MySQL.\n\n1.  **Combine Data**: To aggregate beds from both `hospitals` and `clinics` tables, a `UNION ALL` operation is used. This creates a virtual table with `territory`, `num_beds`, and an additional `source` column ('hospital' or 'clinic') to distinguish the origin of the beds.\n2.  **Conditional Aggregation**: After combining the data, `GROUP BY territory` is applied. `SUM` with `CASE` statements is then used to conditionally sum `num_beds` based on the `source` column to get `total_hospital_beds` and `total_clinic_beds`. If a territory has no beds from a specific source type, the `SUM(CASE WHEN ... THEN num_beds ELSE 0 END)` will correctly return 0.\n3.  **Calculate Total Beds**: The `total_beds` for each territory is simply the sum of all `num_beds` within that territory from the combined dataset.\n4.  **Order Results**: Finally, the results are ordered in descending order by `total_beds` as requested by the problem."
}