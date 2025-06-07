WITH BestCustomer AS (
    SELECT TOP 1
        c.CustomerID,
        p.FirstName,
        p.LastName,
        SUM(soh.TotalDue) AS TotalSales
    FROM Sales.Customer c
    JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    GROUP BY c.CustomerID, p.FirstName, p.LastName
    ORDER BY TotalSales DESC
)
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    bc.FirstName+' '+bc.LastName as BestCustomer
FROM Sales.SalesOrderHeader soh
JOIN BestCustomer bc ON soh.CustomerID = bc.CustomerID
ORDER BY soh.OrderDate

