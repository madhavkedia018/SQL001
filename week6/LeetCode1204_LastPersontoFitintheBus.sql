WITH CumulativeWeights AS (
    SELECT 
        person_name,
        turn,
        SUM(weight) OVER 
        (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
         AS cum_weight
    FROM Queue
)
SELECT TOP 1 person_name
FROM CumulativeWeights
WHERE cum_weight <= 1000
ORDER BY turn DESC
