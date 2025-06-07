SELECT DISTINCT
    p.ProductID,
    p.Name AS ProductName,
    soh.OrderDate
FROM Sales.SalesOrderHeader soh
JOIN Person.Address addr ON soh.ShipToAddressID = addr.AddressID
JOIN Person.StateProvince sp ON addr.StateProvinceID = sp.StateProvinceID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE sp.CountryRegionCode = 'FR'
ORDER BY soh.OrderDate, p.Name
