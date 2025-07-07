SELECT 
    ISNULL(ProductCategory, 'Total') AS ProductCategory,
    ISNULL(ProductName, 'Total') AS ProductName,
    SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP(ProductCategory, ProductName)
ORDER BY 
    GROUPING(ProductCategory), ProductCategory, 
    GROUPING(ProductName), ProductName


  
-- Only category totals + grand total
SELECT 
    ISNULL(ProductCategory, 'Total') AS ProductCategory,
    SUM(SaleAmount) AS CategoryTotal
FROM Sales
GROUP BY ROLLUP(ProductCategory)
ORDER BY GROUPING(ProductCategory), ProductCategory
