WITH OrderTotals AS (
    SELECT 
        SalesOrderID,
        SUM(LineTotal) AS TotalAmount
    FROM Sales.SalesOrderDetail
    GROUP BY SalesOrderID
),

MaxOrder AS (
    SELECT TOP 1 SalesOrderID, TotalAmount
    FROM OrderTotals
    ORDER BY TotalAmount DESC
)

SELECT DISTINCT
    soh.SalesOrderID,
    soh.OrderDate,
    c.CustomerID,
    COALESCE(p.FirstName + ' ' + p.LastName, s.Name) AS CustomerName,
    od.ProductID,
    pr.Name AS ProductName,
    od.OrderQty,
    od.UnitPrice,
    od.LineTotal,
    mo.TotalAmount
FROM MaxOrder mo
JOIN Sales.SalesOrderHeader soh ON mo.SalesOrderID = soh.SalesOrderID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
JOIN Sales.SalesOrderDetail od ON mo.SalesOrderID = od.SalesOrderID
JOIN Production.Product pr ON od.ProductID = pr.ProductID
