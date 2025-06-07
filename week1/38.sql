SELECT TOP 1 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    p.FirstName + ' ' + p.LastName AS CustomerName
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
ORDER BY soh.TotalDue DESC
