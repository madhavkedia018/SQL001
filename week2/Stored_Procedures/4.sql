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


    DELETE FROM OrderDetails
    WHERE OrderID = @OrderID AND ProductID = @ProductID


    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Order detail successfully deleted.'
        RETURN 0
    END
END
