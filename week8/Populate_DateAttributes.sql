CREATE PROCEDURE PopulateDimDate
    @InputDate DATE
AS
BEGIN

    DECLARE @StartDate DATE = DATEFROMPARTS(YEAR(@InputDate), 1, 1)
    DECLARE @EndDate DATE = DATEFROMPARTS(YEAR(@InputDate), 12, 31)

    ;WITH DateSequence AS ( SELECT @StartDate AS DateValue UNION ALL
                           SELECT DATEADD(DAY, 1, DateValue) FROM DateSequence
                           WHERE DATEADD(DAY, 1, DateValue) <= @EndDate )

    INSERT INTO DimDate ( SKDate, KeyDate, Date,
        CalendarDay, CalendarMonth, CalendarQuarter, CalendarYear,
        DayName, DayNameShort, DayNumberOfWeek, DayNumberOfYear, DaySuffix,
        FiscalWeek, FiscalPeriod, FiscalQuarter, FiscalYear, FiscalYearPeriod )
    SELECT
        CONVERT(INT, FORMAT(DateValue, 'yyyyMMdd')),
        FORMAT(DateValue, 'MM/dd/yyyy'),
        FORMAT(DateValue, 'MM/dd/yyyy'),
        DAY(DateValue),
        MONTH(DateValue),
        DATEPART(QUARTER, DateValue),
        YEAR(DateValue),
        DATENAME(WEEKDAY, DateValue),
        LEFT(DATENAME(WEEKDAY, DateValue), 3),
        DATEPART(WEEKDAY, DateValue),
        DATEPART(DAYOFYEAR, DateValue),
        CAST(DAY(DateValue) AS VARCHAR) +
            CASE 
                WHEN DAY(DateValue) IN (11,12,13) THEN 'th'
                WHEN RIGHT(CAST(DAY(DateValue) AS VARCHAR),1) = '1' THEN 'st'
                WHEN RIGHT(CAST(DAY(DateValue) AS VARCHAR),1) = '2' THEN 'nd'
                WHEN RIGHT(CAST(DAY(DateValue) AS VARCHAR),1) = '3' THEN 'rd'
                ELSE 'th'
            END,
        DATEPART(WEEK, DateValue),
        DATEPART(MONTH, DateValue),
        CAST(DATEPART(QUARTER, DateValue) AS VARCHAR),
        YEAR(DateValue),
        CAST(YEAR(DateValue) AS VARCHAR) + CAST(DATEPART(MONTH, DateValue) AS VARCHAR)
    FROM DateSequence
    OPTION (MAXRECURSION 366)
END
