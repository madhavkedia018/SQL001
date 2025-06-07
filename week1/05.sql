SELECT 
    ProductID,
    Name AS ProductName,
    ProductNumber,
    Color,
    StandardCost,
    ListPrice
FROM Production.Product
ORDER BY Name 
