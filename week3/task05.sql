
WITH DailySubmissionCount AS (
    SELECT 
        submission_date,
        hacker_id,
        COUNT(*) AS submission_count
    FROM Submissions
    GROUP BY submission_date, hacker_id
),
DailyMaxRanked AS (
    SELECT 
        submission_date,
        hacker_id,
        submission_count,
        RANK() OVER (PARTITION BY submission_date ORDER BY submission_count DESC, hacker_id ASC) AS rnk
    FROM DailySubmissionCount
),
TopHackers AS (
    SELECT 
        submission_date,
        hacker_id
    FROM DailyMaxRanked
    WHERE rnk = 1
),
DailyUniqueHackers AS (
    SELECT 
        submission_date,
        COUNT(DISTINCT hacker_id) AS unique_hackers
    FROM Submissions
    GROUP BY submission_date
)
SELECT 
    duh.submission_date,
    duh.unique_hackers,
    th.hacker_id,
    h.name
FROM TopHackers th
JOIN Hackers h ON th.hacker_id = h.hacker_id
JOIN DailyUniqueHackers duh ON th.submission_date = duh.submission_date
ORDER BY duh.submission_date
