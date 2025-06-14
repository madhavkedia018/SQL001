CREATE TRIGGER trg_InsertOrderDetails_CheckStock
ON OrderDetails
INSTEAD OF INSERT
AS
BEGIN

    DECLARE @ProductID INT, @Quantity INT, @UnitsInStock INT


    SELECT TOP 1 @ProductID = ProductID, @Quantity = Quantity
    FROM INSERTED

    SELECT @UnitsInStock = UnitsInStock
    FROM Products
    WHERE ProductID = @ProductID

    -- Check if sufficient stock is available
    IF @UnitsInStock IS NOT NULL AND @UnitsInStock >= @Quantity
    BEGIN

        INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
        SELECT OrderID, ProductID, UnitPrice, Quantity, Discount
        FROM INSERTED

        -- Update stock
        UPDATE Products
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID
    END

    ELSE
    BEGIN
        PRINT 'Order could not be placed due to insufficient stock.'
    END
END
