-- Which countries have seen the most significant %-increase 
-- in the number of participating athletes over time in the 
-- last two winter Olympic games (2010 and 2014)? 

-- Let’s look at countries that had at least 
-- 10 athletes in the 2010 Winter Olympics.


with winter_2010 AS (
  
SELECT noc, COUNT(DISTINCT id)
FROM athletes_events
WHERE season='Winter' AND year=2010 
GROUP BY  noc
HAVING COUNT(DISTINCT id)>=10

),

wt AS (SELECT  w.noc, 
CASE WHEN a.year=2010 then '2010_'
WHEN a.year=2014 then '2014_'
END AS winter_years,

COUNT(DISTINCT a.id) as num_athletes

FROM winter_2010 w
JOIN athletes_events a
ON w.noc=a.noc
WHERE a.year>=2010 AND a.year<=2014 AND a.season='Winter'
GROUP BY  w.noc,winter_years
),

previous AS (SELECT noc,winter_years, SUM(num_athletes) as total_ath,
LAG(SUM(num_athletes)) OVER(PARTITION BY noc ORDER BY winter_years ASC) as prev
FROM wt
GROUP BY noc, winter_years
ORDER BY 1,2
)

SELECT noc, winter_years, total_ath, prev, ROUND((total_ath - prev)::FLOAT / total_ath *100) AS perc_increase
FROM previous
WHERE ROUND((total_ath - prev)::FLOAT / total_ath *100) IS NOT NULL
ORDER BY 5 DESC

