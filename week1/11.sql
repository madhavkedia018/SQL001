SELECT 
    fo.SalesOrderID,
    fo.OrderDate,
    fo.CustomerID,
    COALESCE(p.FirstName + ' ' + p.LastName, s.Name) AS CustomerName,
    sod.ProductID,
    pr.Name AS ProductName,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal
FROM FirstOrder fo
JOIN Sales.SalesOrderDetail sod ON fo.SalesOrderID = sod.SalesOrderID
LEFT JOIN Sales.Customer c ON fo.CustomerID = c.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
