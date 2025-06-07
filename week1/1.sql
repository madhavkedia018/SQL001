SELECT FirstName,MiddleName,LastName 
FROM Person.Person P 
INNER JOIN  Sales.Customer S
ON P.BusinessEntityID = S.PersonID
