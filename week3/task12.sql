CREATE TABLE Employees_Worldwide (
    employee_id INT,
    job_family VARCHAR(50),
    location VARCHAR(20),
    cost DECIMAL(10, 2)
)

INSERT INTO Employees_Worldwide VALUES
(1, 'Engineering', 'India', 5000),
(2, 'Engineering', 'India', 6000),
(3, 'Engineering', 'Germany', 9000),
(4, 'Engineering', 'France', 7000),
(5, 'HR', 'India', 3000),
(6, 'HR', 'Italy', 5000),
(7, 'HR', 'India', 2500),
(8, 'Sales', 'Spain', 8000),
(9, 'Sales', 'India', 4000),
(10, 'Sales', 'Germany', 6000)



SELECT
    job_family,
    ROUND( 100.0 * SUM(CASE WHEN location = 'India' THEN cost ELSE 0 END) / NULLIF(SUM(cost), 0), 2) AS india_cost_percent,
    ROUND( 100.0 * SUM(CASE WHEN location <> 'India' THEN cost ELSE 0 END) / NULLIF(SUM(cost), 0), 2) AS international_cost_percent
FROM Employees_Worldwide
GROUP BY job_family
