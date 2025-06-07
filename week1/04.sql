SELECT DISTINCT
    c.CustomerID,
     CASE 
        WHEN c.PersonID IS NOT NULL THEN p.FirstName + ' ' + p.LastName
        WHEN c.StoreID IS NOT NULL THEN s.Name
        ELSE 'N/A'
    END AS CustomerName,
    cr.Name AS Country
FROM Sales.Customer c
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
JOIN Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
WHERE cr.Name IN ('United Kingdom', 'United States')
ORDER BY c.CustomerID
