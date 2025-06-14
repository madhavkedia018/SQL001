ALTER VIEW vwCustomerOrders AS
SELECT 
    v.Name AS CompanyName, -- Supplier name
    soh.SalesOrderID AS OrderID,
    CAST(soh.OrderDate AS DATE) as OrderDate,
    p.ProductID,
    p.Name AS ProductName,
    sod.OrderQty AS Quantity,
    sod.UnitPrice,
    (sod.OrderQty * sod.UnitPrice) AS LineTotal
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE 
    CAST(soh.OrderDate AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)


    
SELECT * FROM vwCustomerOrders
