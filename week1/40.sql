SELECT 
    v.BusinessEntityID AS SupplierID,
    v.Name AS SupplierName,
    COUNT(pv.ProductID) AS NumberOfProducts
FROM Purchasing.ProductVendor pv
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
GROUP BY v.BusinessEntityID, v.Name
ORDER BY NumberOfProducts DESC
