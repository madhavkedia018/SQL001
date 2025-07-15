CREATE PROCEDURE Load_SCD_Type_4
AS
BEGIN
    INSERT INTO DimCustomer_History (CustomerID, Name, Address, City, ChangeDate)
    SELECT d.CustomerID, d.Name, d.Address, d.City, GETDATE()
    FROM DimCustomer d
    JOIN StgCustomer s ON d.CustomerID = s.CustomerID
    WHERE d.Name <> s.Name OR d.Address <> s.Address OR d.City <> s.City

    UPDATE DimCustomer
    SET Name = s.Name, Address = s.Address, City = s.City
    FROM DimCustomer d
    JOIN StgCustomer s ON d.CustomerID = s.CustomerID

    INSERT INTO DimCustomer (CustomerID, Name, Address, City, StartDate, EndDate, CurrentFlag)
    SELECT s.CustomerID, s.Name, s.Address, s.City, GETDATE(), NULL, 1
    FROM StgCustomer s
    WHERE NOT EXISTS ( SELECT 1 FROM DimCustomer d WHERE d.CustomerID = s.CustomerID )
END
