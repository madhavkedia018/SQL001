WITH EmployeeHierarchy AS (
    SELECT
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.OrganizationNode,
        e.OrganizationNode.GetAncestor(1) AS SupervisorNode
    FROM HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT 
    eh.BusinessEntityID,
    eh.FirstName AS EmployeeFirstName,
    eh.LastName AS EmployeeLastName,
    sp.FirstName AS SupervisorFirstName,
    sp.LastName AS SupervisorLastName
FROM EmployeeHierarchy eh
LEFT JOIN EmployeeHierarchy sp
    ON eh.SupervisorNode = sp.OrganizationNode
ORDER BY eh.BusinessEntityID

