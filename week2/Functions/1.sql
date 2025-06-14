CREATE FUNCTION dbo.FormatDate_MMDDYYYY (@inputDate DATETIME)
RETURNS VARCHAR(13)
AS
BEGIN
    RETURN RIGHT('0' + CAST(MONTH(@inputDate) AS VARCHAR), 2) +'/'+
           RIGHT('0' + CAST(DAY(@inputDate) AS VARCHAR), 2) +'/'+
           CAST(YEAR(@inputDate) AS VARCHAR)
END


SELECT dbo.FormatDate_MMDDYYYY(GETDATE()) as Date 
