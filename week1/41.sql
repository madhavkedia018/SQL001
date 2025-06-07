SELECT TOP 10
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    SUM(soh.TotalDue) AS TotalBusiness
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY TotalBusiness DESC
