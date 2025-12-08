 -- Tables: Customer, SaleOrder, Payment
 -- Technique: Multi-table Update, CTE (dialect: Mysql)

 UPDATE Customer c
 JOIN (
     WITH CustomerTotalPaid AS (
         SELECT
             c_inner.CustID,
             c_inner.City,
             SUM(p.Amount) AS TotalPaidAmount
         FROM
             Customer c_inner
         JOIN
             SaleOrder so ON c_inner.CustID = so.CustID
         JOIN
             Payment p ON so.OrderID = p.OrderID
         WHERE
             p.Status = 'PAID'
         GROUP BY
             c_inner.CustID, c_inner.City
     ),
     CityMaxPaid AS (
         SELECT
             City,
             MAX(TotalPaidAmount) AS MaxTotalPaidAmount
         FROM
             CustomerTotalPaid
         GROUP BY
             City
     )
     SELECT
         ctp.CustID
     FROM
         CustomerTotalPaid ctp
     JOIN
         CityMaxPaid cmp ON ctp.City = cmp.City AND ctp.TotalPaidAmount = cmp.MaxTotalPaidAmount
 ) AS TopSpenders ON c.CustID = TopSpenders.CustID
 SET c.Tier = 'TOP_CITY';