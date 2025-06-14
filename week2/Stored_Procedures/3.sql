CREATE PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM OrderDetails WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'The Order ID ' + CAST(@OrderID AS VARCHAR) + ' does not exist.'
        RETURN 1
    END

    ELSE        -- If records exist, return the details
        BEGIN
            SELECT *
            FROM OrderDetails
            WHERE OrderID = @OrderID
        END
    
END
