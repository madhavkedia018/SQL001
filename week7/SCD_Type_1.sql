CREATE PROCEDURE Load_SCD_Type_1
AS
BEGIN
    MERGE DimCustomer AS target
    USING StgCustomer AS source
    ON target.CustomerID = source.CustomerID
    WHEN MATCHED AND ( target.Name <> source.Name OR
                       target.Address <> source.Address OR
                       target.City <> source.City )
    THEN UPDATE SET
        target.Name = source.Name,
        target.Address = source.Address,
        target.City = source.City
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (CustomerID, Name, Address, City, StartDate, EndDate, CurrentFlag)
         VALUES (source.CustomerID, source.Name, source.Address, source.City, GETDATE(), NULL, 1)
END
