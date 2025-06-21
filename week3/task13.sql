CREATE TABLE Employee_Financials (
    employee_id INT,
    bu VARCHAR(50),
    month DATE,
    cost DECIMAL(12, 2),
    revenue DECIMAL(12, 2)
)

INSERT INTO Employee_Financials VALUES
(101, 'HR',      '2024-01-01', 5000, 7000),
(102, 'HR',      '2024-01-01', 3000, 6000),
(103, 'HR',      '2024-01-01', 4000, 5000),
(101, 'HR',      '2024-02-01', 5200, 7500),
(102, 'HR',      '2024-02-01', 3100, 6200),
(104, 'IT',      '2024-01-01', 6000, 12000),
(105, 'IT',      '2024-01-01', 3500, 10000),
(104, 'IT',      '2024-02-01', 6200, 13000),
(105, 'IT',      '2024-02-01', 3600, 10500),
(106, 'Finance', '2024-01-01', 4500, 5000),
(107, 'Finance', '2024-01-01', 5000, 6000),
(106, 'Finance', '2024-02-01', 4800, 6000)


SELECT
    bu,
    FORMAT(month, 'yyyy-MM') AS month,
    SUM(cost) AS total_cost,
    SUM(revenue) AS total_revenue,
    ROUND(SUM(cost) * 1.0 / NULLIF(SUM(revenue), 0), 2) AS cost_to_revenue_ratio
FROM Employee_Financials
GROUP BY bu, month
ORDER BY bu, month
