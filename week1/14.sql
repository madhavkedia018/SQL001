
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    COALESCE(p.FirstName + ' ' + p.LastName, st.Name) AS CustomerName,
    MIN(sod.OrderQty) AS MinQuantity,
    MAX(sod.OrderQty) AS MaxQuantity
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store st ON c.StoreID = st.BusinessEntityID
GROUP BY 
    soh.SalesOrderID,
    soh.OrderDate,
    COALESCE(p.FirstName + ' ' + p.LastName, st.Name)
ORDER BY soh.SalesOrderID
