SELECT 
    soh.SalesOrderID,
    p.FirstName+' '+p.LastName as CustomerName,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.PersonPhone pp ON pp.BusinessEntityID = p.BusinessEntityID
LEFT JOIN Person.PhoneNumberType pnt ON pp.PhoneNumberTypeID = pnt.PhoneNumberTypeID AND pnt.Name = 'Fax'
WHERE pnt.PhoneNumberTypeID IS NULL
ORDER BY soh.SalesOrderID
