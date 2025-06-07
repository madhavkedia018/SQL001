SELECT DISTINCT
    addr.PostalCode,
    p.Name
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Person.Address addr ON soh.ShipToAddressID = addr.AddressID
WHERE p.Name = 'Tofu'
  AND addr.PostalCode IS NOT NULL
ORDER BY addr.PostalCode
