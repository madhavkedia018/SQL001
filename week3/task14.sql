CREATE TABLE Employees (
    employee_id INT,
    sub_band VARCHAR(50)
)

INSERT INTO Employees VALUES
(1, 'A1'), (2, 'A1'), (3, 'A2'), (4, 'A2'), (5, 'A2'),
(6, 'B1'), (7, 'A2'), (8, 'A2'), (9, 'B1'), (10, 'A2')


SELECT
    sub_band,
    COUNT(*) AS headcount,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Employees
GROUP BY sub_band
