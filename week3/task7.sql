WITH numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n + 1 <= 1000
),
primes AS (
    SELECT n FROM numbers n1
    WHERE NOT EXISTS (
        SELECT 1 FROM numbers n2
        WHERE n2.n < n1.n AND n2.n > 1 AND n1.n % n2.n = 0
    )
)
SELECT STRING_AGG(CAST(n AS VARCHAR), '&') AS prime_numbers_less_than_or_equal_to_1000
FROM primes
OPTION (MAXRECURSION 1000)
