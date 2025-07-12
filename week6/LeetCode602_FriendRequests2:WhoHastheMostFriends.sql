SELECT TOP 1 id, COUNT(*) AS num
FROM ( SELECT requester_id AS id FROM RequestAccepted
       UNION ALL SELECT accepter_id FROM RequestAccepted ) AS all_friends
GROUP BY id
ORDER BY num DESC
