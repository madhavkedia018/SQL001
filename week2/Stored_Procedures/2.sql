CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity SMALLINT = NULL,
    @Discount REAL = NULL
AS
BEGIN
    

    IF @UnitPrice IS NOT NULL
    BEGIN
        UPDATE OrderDetails
        SET UnitPrice = @UnitPrice
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    END

    IF @Quantity IS NOT NULL
    BEGIN
        SELECT @OldQuantity = Quantity
        FROM OrderDetails
        WHERE OrderID = @OrderID AND ProductID = @ProductID

        UPDATE OrderDetails
        SET Quantity = @Quantity
        WHERE OrderID = @OrderID AND ProductID = @ProductID


        UPDATE Products
        SET UnitsInStock = UnitsInStock + @OldQuantity - @Quantity
        WHERE ProductID = @ProductID
    END


    IF @Discount IS NOT NULL
    BEGIN
        UPDATE OrderDetails
        SET Discount = @Discount
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    END
END
