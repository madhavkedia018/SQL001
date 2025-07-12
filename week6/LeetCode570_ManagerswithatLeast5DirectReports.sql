SELECT E.name
FROM Employee E
JOIN 
    ( SELECT managerId FROM Employee
      WHERE managerId IS NOT NULL
      GROUP BY managerId
      HAVING COUNT(*) >= 5
    ) M 
ON E.id = M.managerId;
