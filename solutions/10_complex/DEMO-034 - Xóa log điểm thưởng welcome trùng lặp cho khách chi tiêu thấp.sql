DELETE lh
FROM LoyaltyHistory lh
JOIN (
    SELECT CustID
    FROM SaleOrder
    GROUP BY CustID
    HAVING SUM(TotalAmount) < 1000
) AS LowSpendingCustomers ON lh.CustID = LowSpendingCustomers.CustID
JOIN (
    SELECT
        HistoryID,
        ROW_NUMBER() OVER (PARTITION BY CustID, Reason, PointsChange ORDER BY ChangeDate DESC, HistoryID DESC) as rn
    FROM
        LoyaltyHistory
    WHERE
        Reason = 'WELCOME_BONUS'
) AS RankedWelcomeBonuses ON lh.HistoryID = RankedWelcomeBonuses.HistoryID
WHERE
    RankedWelcomeBonuses.rn > 1;