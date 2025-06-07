SELECT DISTINCT
    mgr.BusinessEntityID AS ManagerID,
    p.FirstName + ' ' + p.LastName AS ManagerName,
    COUNT(emp.BusinessEntityID) AS NumberOfReports
FROM HumanResources.Employee emp
JOIN HumanResources.Employee mgr ON emp.OrganizationNode.GetAncestor(1) = mgr.OrganizationNode
JOIN Person.Person p ON mgr.BusinessEntityID = p.BusinessEntityID
GROUP BY mgr.BusinessEntityID, p.FirstName, p.LastName
ORDER BY NumberOfReports DESC
