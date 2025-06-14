CREATE FUNCTION dbo.FormatDate_YYYYMMDD (@inputDate DATETIME)
RETURNS VARCHAR(13)
AS
BEGIN
    RETURN CAST(YEAR(@inputDate) AS VARCHAR) +
           RIGHT('0' + CAST(MONTH(@inputDate) AS VARCHAR), 2) +
           RIGHT('0' + CAST(DAY(@inputDate) AS VARCHAR), 2)
END


SELECT dbo.FormatDate_YYYYMMDD(GETDATE()) as Date
