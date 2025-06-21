WITH RankedOccupations AS (
    SELECT 
        name,
        occupation,
        ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn
    FROM Occupations
),
Pivoted AS (
    SELECT
        MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
        MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
        MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
        MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor,
        rn
    FROM RankedOccupations
    GROUP BY rn
)
SELECT Doctor, Professor, Singer, Actor
FROM Pivoted
ORDER BY rn
