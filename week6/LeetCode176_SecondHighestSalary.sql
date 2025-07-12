SELECT ( SELECT DISTINCT TOP 1 salary
         FROM Employee
         WHERE salary < (SELECT MAX(salary) FROM Employee)
         ORDER BY salary DESC ) AS SecondHighestSalary
