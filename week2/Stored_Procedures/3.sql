CREATE PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM OrderDetails WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'The Order ID ' + CAST(@OrderID AS VARCHAR) + ' does not exist.'
        RETURN 1
    END

    -- If records exist, return the details
    SELECT *
    FROM OrderDetails
    WHERE OrderID = @OrderID
END
