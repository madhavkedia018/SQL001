SELECT DISTINCT
    p.ProductID,
    p.Name,
    p.ProductNumber,
    p.ListPrice,
    soh.OrderDate
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE p.SellEndDate IS NOT NULL
  AND p.SellEndDate < GETDATE()
  AND soh.OrderDate >= '1997-01-01'
  AND soh.OrderDate < '1998-01-01'
ORDER BY soh.OrderDate
