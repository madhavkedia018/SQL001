CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    salary INT
)

INSERT INTO Employees (employee_id, salary) VALUES
(1, 50200),
(2, 45000),
(3, 1000),
(4, 8000),
(5, 75000),
(6, 6000)


SELECT 
    AVG(CAST(salary AS FLOAT)) as Actual_avg_salary,
    AVG(CAST(REPLACE(CAST(salary AS VARCHAR), '0', '') AS FLOAT)) as Calculated_avg_salary,
    CEILING(
        AVG(CAST(salary AS FLOAT)) - 
        AVG(CAST(REPLACE(CAST(salary AS VARCHAR), '0', '') AS FLOAT))
    ) AS salary_error
FROM Employees
