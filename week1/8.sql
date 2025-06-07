SELECT DISTINCT
    c.CustomerID,
    CASE 
        WHEN c.PersonID IS NOT NULL THEN p.FirstName + ' ' + p.LastName
        WHEN c.StoreID IS NOT NULL THEN s.Name
        ELSE 'N/A'
    END AS CustomerName,
    a.City,
    pr.Name AS ProductPurchased
FROM Sales.Customer c
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
JOIN Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
WHERE a.City = 'London'
  AND pr.Name = 'Chai'


