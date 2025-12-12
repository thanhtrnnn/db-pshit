DELETE oi 
FROM ORDER_ITEM oi 
JOIN PRODUCT p ON oi.ProductID = p.ProductID 
LEFT JOIN CATEGORY c ON p.CategoryID = c.CategoryID 
WHERE p.Discontinued = 1 OR c.CategoryName = 'Obsolete';

-- subquery version
Delete from ORDER_ITEM
Where ProductID in (
    Select ProductID
    From PRODUCT 
    Where CategoryID in (
        Select CategoryID
        From CATEGORY 
        Where CategoryName = 'Obsolete'
    ) or Discontinued = 1
);