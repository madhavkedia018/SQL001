CREATE TABLE Employees (
    employee_id INT,
    employee_name VARCHAR(100),
    salary MONEY
)

INSERT INTO Employees VALUES
(101, 'Alice', '85000'),
(102, 'Bob', '95000'),
(103, 'Charlie', '87000'),
(104, 'Diana', '92000'),
(105, 'Ethan', '91500'),
(106, 'Fiona', '89000'),
(107, 'George', '97000'),
(108, 'Hannah', '91000'),
(109, 'Ian', '87500'),
(110, 'Julia', '88000')

WITH RankedEmployees AS (
    SELECT
        employee_id,
        employee_name,
        salary,
        RANK() OVER (PARTITION BY 1 ORDER BY salary DESC) AS rank
    FROM Employees
)
SELECT
    employee_id,
    employee_name,
    salary
FROM RankedEmployees
WHERE rank <= 5
