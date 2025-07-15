CREATE PROCEDURE Load_SCD_Type_3
AS
BEGIN
    UPDATE d
    SET d.PreviousAddress = d.Address, d.Address = s.Address
    FROM DimCustomer d
    JOIN StgCustomer s ON d.CustomerID = s.CustomerID
    WHERE d.Address <> s.Address

    INSERT INTO DimCustomer (CustomerID, Name, Address, City, StartDate, EndDate, CurrentFlag)
    SELECT s.CustomerID, s.Name, s.Address, s.City, GETDATE(), NULL, 1
    FROM StgCustomer s
    WHERE NOT EXISTS ( SELECT 1 FROM DimCustomer d WHERE d.CustomerID = s.CustomerID )
END
