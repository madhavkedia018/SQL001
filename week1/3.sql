SELECT 
    c.CustomerID,
     CASE 
        WHEN c.PersonID IS NOT NULL THEN p.FirstName + ' ' + p.LastName
        WHEN c.StoreID IS NOT NULL THEN s.Name
        ELSE 'N/A'
    END AS CustomerName,
    a.City
FROM Sales.Customer c
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
JOIN Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
WHERE a.City IN ('London', 'Berlin')
ORDER BY c.CustomerID
