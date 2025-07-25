SELECT 
    CASE 
        WHEN id & 1 = 1 AND id + 1 <= (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id & 1 = 0 THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id
