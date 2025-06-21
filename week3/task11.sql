SELECT S.Name
FROM students S
JOIN friends F ON S.id = F.id
JOIN packages P1 ON S.id = P1.id        
JOIN packages P2 ON F.friend_id = P2.id  
WHERE P2.salary > P1.salary
ORDER BY P2.salary
