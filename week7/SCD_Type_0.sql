CREATE OR ALTER PROCEDURE Load_SCD_Type_0
AS
BEGIN
    INSERT INTO DimCustomer (CustomerID, Name, Address, City, StartDate, EndDate, CurrentFlag)
    SELECT s.CustomerID, s.Name, s.Address, s.City, GETDATE(), NULL, 1
    FROM StgCustomer s
    WHERE NOT EXISTS ( SELECT 1 FROM DimCustomer d WHERE d.CustomerID = s.CustomerID )
END
