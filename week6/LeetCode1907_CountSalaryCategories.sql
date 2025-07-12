SELECT category, COUNT(A.account_id) AS accounts_count
FROM (  SELECT 'Low Salary' AS category
        UNION ALL SELECT 'Average Salary'
        UNION ALL SELECT 'High Salary' ) AS categories
LEFT JOIN Accounts A ON
    (categories.category = 'Low Salary' AND A.income < 20000) OR
    (categories.category = 'Average Salary' AND A.income BETWEEN 20000 AND 50000) OR
    (categories.category = 'High Salary' AND A.income > 50000)
GROUP BY category
