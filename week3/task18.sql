CREATE TABLE Employee_Costs (
    employee_id INT,
    bu VARCHAR(50),
    month DATE,
    cost DECIMAL(10, 2),
    weight DECIMAL(4, 2)
)

INSERT INTO Employee_Costs VALUES
(101, 'HR',  '2024-01-01', 5000.00, 1.0),
(102, 'HR',  '2024-01-01', 3000.00, 0.5),
(103, 'HR',  '2024-01-01', 4000.00, 1.0),
(104, 'IT',  '2024-01-01', 6000.00, 1.0),
(105, 'IT',  '2024-01-01', 3500.00, 0.8),
(101, 'HR',  '2024-02-01', 5200.00, 1.0),
(102, 'HR',  '2024-02-01', 3100.00, 0.5),
(104, 'IT',  '2024-02-01', 6200.00, 1.0),
(105, 'IT',  '2024-02-01', 3600.00, 0.8)


SELECT
    bu,
    FORMAT(month, 'yyyy-MM') AS month,
    ROUND(SUM(cost * weight) / NULLIF(SUM(weight), 0), 2) AS weighted_avg_cost
FROM Employee_Costs
GROUP BY bu, month
ORDER BY bu, month
