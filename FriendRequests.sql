WITH CTE AS (
    SELECT requester_id AS r1 FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS r1 FROM RequestAccepted
),
ACTE AS (
    SELECT r1 AS id, COUNT(r1) AS num 
    FROM CTE 
    GROUP BY r1
)
SELECT id, num 
FROM ACTE 
ORDER BY num DESC 
LIMIT 1;