SELECT 
    e.BusinessEntityID AS EmployeeID,
    p.FirstName+' '+p.LastName AS EmployeName,
    ISNULL(SUM(soh.TotalDue), 0) AS TotalSales
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
LEFT JOIN Sales.SalesPerson sp ON e.BusinessEntityID = sp.BusinessEntityID
LEFT JOIN Sales.SalesOrderHeader soh ON sp.BusinessEntityID = soh.SalesPersonID
GROUP BY e.BusinessEntityID, p.FirstName, p.LastName
ORDER BY TotalSales DESC
