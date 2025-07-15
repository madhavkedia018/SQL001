CREATE PROCEDURE Load_SCD_Type_2
AS
BEGIN
    DECLARE @Today DATE = GETDATE()

    UPDATE DimCustomer
    SET EndDate = @Today, CurrentFlag = 0
    FROM DimCustomer d
    JOIN StgCustomer s ON d.CustomerID = s.CustomerID
    WHERE d.CurrentFlag = 1 AND ( d.Name <> s.Name OR
                                  d.Address <> s.Address OR
                                  d.City <> s.City )

    INSERT INTO DimCustomer (CustomerID, Name, Address, City, StartDate, EndDate, CurrentFlag)
    SELECT s.CustomerID, s.Name, s.Address, s.City, @Today, NULL, 1
    FROM StgCustomer s
    WHERE NOT EXISTS ( SELECT 1 FROM DimCustomer d WHERE d.CustomerID = s.CustomerID AND d.CurrentFlag = 1 )
END
