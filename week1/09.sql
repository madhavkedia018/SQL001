  SELECT DISTINCT
    c.CustomerID,
    COALESCE(p.FirstName + ' ' + p.LastName, s.Name) AS CustomerName
FROM Sales.Customer c
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL
ORDER BY c.CustomerID
