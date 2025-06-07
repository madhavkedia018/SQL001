SELECT 
    p.FirstName + ' ' + p.LastName AS CustomerName,
    pp.PhoneNumber,
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.PersonPhone pp ON p.BusinessEntityID = pp.BusinessEntityID
GROUP BY p.FirstName, p.LastName, pp.PhoneNumber
HAVING COUNT(soh.SalesOrderID) > 3
ORDER BY NumberOfOrders DESC
