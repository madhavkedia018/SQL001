CREATE TRIGGER trg_DeleteOrderAndDetails
ON Orders
INSTEAD OF DELETE
AS
BEGIN
    -- Delete related order details first
    DELETE FROM OrderDetails
    WHERE OrderID IN (SELECT OrderID FROM DELETED)

    -- Then delete the order itself
    DELETE FROM Orders
    WHERE OrderID IN (SELECT OrderID FROM DELETED)

END 
