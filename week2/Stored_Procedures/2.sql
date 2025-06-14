CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity SMALLINT = NULL,
    @Discount REAL = NULL
AS
BEGIN
    
    -- Update UnitPrice if provided
    IF @UnitPrice IS NOT NULL
    BEGIN
        UPDATE OrderDetails
        SET UnitPrice = @UnitPrice
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    END

    -- Update Quantity if provided
    IF @Quantity IS NOT NULL
    BEGIN
        SELECT @OldQuantity = Quantity
        FROM OrderDetails
        WHERE OrderID = @OrderID AND ProductID = @ProductID

        -- Update OrderDetails
        UPDATE OrderDetails
        SET Quantity = @Quantity
        WHERE OrderID = @OrderID AND ProductID = @ProductID

        -- Adjust stock: Add back old, subtract new
        UPDATE Products
        SET UnitsInStock = UnitsInStock + @OldQuantity - @Quantity
        WHERE ProductID = @ProductID
    END

    -- Update Discount if provided
    IF @Discount IS NOT NULL
    BEGIN
        UPDATE OrderDetails
        SET Discount = @Discount
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    END
END
