    SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    COALESCE(SUM(s.total_submissions), 0) AS total_submissions,
    COALESCE(SUM(s.total_accepted_submissions), 0) AS total_accepted_submissions,
    COALESCE(SUM(v.total_views), 0) AS total_views,
    COALESCE(SUM(v.total_unique_views), 0) AS total_unique_views
FROM Contests c
JOIN Colleges col ON c.contest_id = col.contest_id
JOIN Challenges ch ON col.college_id = ch.college_id
LEFT JOIN View_Stats v ON ch.challenge_id = v.challenge_id
LEFT JOIN Submission_Stats s ON ch.challenge_id = s.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING 
    COALESCE(SUM(s.total_submissions), 0) +
    COALESCE(SUM(s.total_accepted_submissions), 0) +
    COALESCE(SUM(v.total_views), 0) +
    COALESCE(SUM(v.total_unique_views), 0) > 0
ORDER BY c.contest_id
