SELECT DISTINCT
    c.CustomerID,
    CASE 
        WHEN c.PersonID IS NOT NULL THEN p.FirstName + ' ' + p.LastName
        WHEN c.StoreID IS NOT NULL THEN s.Name
        ELSE 'N/A'
    END AS CustomerName
FROM Sales.Customer c
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
ORDER BY c.CustomerID
