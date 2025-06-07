SELECT 
    p.ProductID,
    p.Name AS ProductName,
    SUM(pi.Quantity) AS TotalStock
FROM Production.Product p
JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    AND EXISTS (
        SELECT 1 
        FROM Sales.SalesOrderHeader soh 
        WHERE soh.SalesOrderID = sod.SalesOrderID
          AND soh.Status IN (1,2,3,4)
    )
GROUP BY p.ProductID, p.Name
HAVING SUM(pi.Quantity) < 10 AND COUNT(sod.SalesOrderID) = 0
ORDER BY p.ProductID

