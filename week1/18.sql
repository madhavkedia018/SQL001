SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.ShipToAddressID,
    a.City,
    cr.Name AS Country
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
WHERE cr.Name = 'Canada'
ORDER BY soh.OrderDate
