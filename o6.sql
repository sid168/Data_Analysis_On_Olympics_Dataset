-- For each season (summer/winter), 
-- which years did we see the highest percentage increase in female 
-- participation?



WITH previous AS (
SELECT  
CASE WHEN season='Summer' THEN 'summer_season'
WHEN season='Winter' THEN 'winter_season'
END AS seasons,
year, COUNT(*) as female_count,
LAG(COUNT(*)) OVER(PARTITION BY year ORDER BY year ASC) as prev_season_female_count
FROM athletes_events
WHERE sex='F'
GROUP BY seasons,year
ORDER BY year
) 

SELECT year, (prev_season_female_count-female_count)::FLOAT / prev_season_female_count * 100 AS perc_increase 
FROM previous

WHERE female_count IS NOT NULL AND prev_season_female_count IS NOT NULL
ORDER BY 2 DESC







