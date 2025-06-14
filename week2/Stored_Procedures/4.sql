CREATE PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    -- Check if the order ID exists
    IF NOT EXISTS (SELECT 1 FROM OrderDetails WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'Invalid OrderID. This order does not exist.'
        RETURN -1
    END

    -- Check if the product ID exists in that order
    IF NOT EXISTS (SELECT 1 FROM OrderDetails WHERE OrderID = @OrderID AND ProductID = @ProductID)
    BEGIN
        PRINT 'Invalid ProductID for the given OrderID.'
        RETURN -1
    END

    -- Perform delete
    DELETE FROM OrderDetails
    WHERE OrderID = @OrderID AND ProductID = @ProductID

    -- Confirm deletion
    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Order detail successfully deleted.'
        RETURN 0
    END
    ELSE
    BEGIN
        PRINT 'No rows deleted (unexpected case).'
        RETURN -1
    END
END
