WITH EmployeeHierarchy AS (
    SELECT
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.OrganizationNode,
        e.OrganizationNode.GetAncestor(1) AS SupervisorNode
    FROM HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
),
DirectReports AS (
    SELECT
        SupervisorNode,
        COUNT(*) AS ReportCount
    FROM EmployeeHierarchy
    WHERE SupervisorNode IS NOT NULL
    GROUP BY SupervisorNode
)
SELECT
    p.FirstName+' '+p.LastName AS ManagerName,
    dr.ReportCount
FROM DirectReports dr
JOIN EmployeeHierarchy eh ON dr.SupervisorNode = eh.OrganizationNode
JOIN Person.Person p ON eh.BusinessEntityID = p.BusinessEntityID
WHERE dr.ReportCount > 4
ORDER BY dr.ReportCount DESC
