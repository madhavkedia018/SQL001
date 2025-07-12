WITH 
DailyTotals AS (
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on),
SevenDayWindow AS (
    SELECT a.visited_on, SUM(b.amount) AS amount,
    ROUND(AVG(1.0 * b.amount), 2) AS average_amount
    FROM DailyTotals a
    JOIN DailyTotals b 
    ON b.visited_on BETWEEN DATEADD(DAY, -6, a.visited_on) AND a.visited_on
    GROUP BY a.visited_on)

SELECT * FROM SevenDayWindow
WHERE visited_on >=(SELECT DATEADD(DAY, 6, MIN(visited_on)) FROM DailyTotals)
ORDER BY visited_on

