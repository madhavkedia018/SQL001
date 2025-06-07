SELECT 
    c.CustomerID,
     CASE 
        WHEN c.PersonID IS NOT NULL THEN p.FirstName + ' ' + p.LastName
        WHEN c.StoreID IS NOT NULL THEN s.Name
        ELSE 'N/A'
    END AS CustomerName,
    s.Name AS CompanyName
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
WHERE s.Name LIKE '%n';
