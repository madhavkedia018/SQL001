SELECT 
    SalesOrderID,
    SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) > 300
ORDER BY TotalQuantity DESC
