CREATE PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity SMALLINT,
    @Discount REAL = 0
AS
BEGIN

    IF @UnitPrice IS NULL
    BEGIN
        SELECT @UnitPrice = UnitPrice
        FROM Products
        WHERE ProductID = @ProductID;
    END


    SELECT @CurrentStock = UnitsInStock, @ReorderLevel = ReorderLevel
    FROM Products
    WHERE ProductID = @ProductID

    IF @CurrentStock IS NULL OR @CurrentStock < @Quantity RETURN -1;
            INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
            VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)

            IF @@ROWCOUNT = 0
                PRINT 'Failed to place the order. Please try again.'
            ELSE 
               BEGIN
                      UPDATE Products
                      SET UnitsInStock = UnitsInStock - @Quantity
                      WHERE ProductID = @ProductID

                      DECLARE @NewStock INT;
                      SELECT @NewStock = UnitsInStock
                      FROM Products
                      WHERE ProductID = @ProductID

                      IF @NewStock < @ReorderLevel
                          PRINT 'Warning: Stock for this product has dropped below the reorder level.'
               END

END
