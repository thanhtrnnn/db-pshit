 -- Tables: Customer, SaleOrder, Payment
 -- Technique: Multi-table Update, CTE (dialect: Mysql)

WITH CustomerRanking AS (
    SELECT 
        c.CustID,
        RANK() OVER (PARTITION BY c.City ORDER BY SUM(p.Amount) DESC) as RankInCity
    FROM 
        Customer c
    JOIN 
        SaleOrder s ON c.CustID = s.CustID
    JOIN 
        Payment p ON s.OrderID = p.OrderID
    WHERE 
        p.Status = 'PAID'
    GROUP BY 
        c.CustID, c.City
)
UPDATE Customer c   
JOIN CustomerRanking cr ON c.CustID = cr.CustID
SET c.Tier = 'TOP_CITY'
WHERE cr.RankInCity = 1;