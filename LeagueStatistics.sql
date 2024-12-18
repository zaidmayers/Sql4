WITH CTE AS (
    SELECT home_team_id AS team_id, 
           home_team_goals AS goals_for, 
           away_team_goals AS goals_against,
           CASE 
               WHEN home_team_goals > away_team_goals THEN 3
               WHEN home_team_goals = away_team_goals THEN 1
               ELSE 0 
           END AS points
    FROM Matches
    UNION ALL
    SELECT away_team_id AS team_id, 
           away_team_goals AS goals_for, 
           home_team_goals AS goals_against,
           CASE 
               WHEN away_team_goals > home_team_goals THEN 3
               WHEN away_team_goals = home_team_goals THEN 1
               ELSE 0 
           END AS points
    FROM Matches
)
SELECT t.team_name, 
       COUNT(c.team_id) AS matches_played,
       SUM(c.points) AS points,
       SUM(c.goals_for) AS goal_for,
       SUM(c.goals_against) AS goal_against,
       SUM(c.goals_for) - SUM(c.goals_against) AS goal_diff
FROM Teams t
JOIN CTE c ON t.team_id = c.team_id
GROUP BY t.team_name
ORDER BY points DESC, goal_diff DESC, t.team_name;
