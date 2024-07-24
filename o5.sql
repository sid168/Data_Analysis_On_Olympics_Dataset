-- Are there specific sports or events that have been phased out? 
-- (pre/post 1980s)

WITH sports_pre_1980s AS (SELECT sport,event FROM athletes_events
WHERE year<1980
)

SELECT DISTINCT sport,event FROM athletes_events
WHERE sport NOT IN (SELECT sport FROM sports_pre_1980s) 
AND event NOT IN (SELECT event FROM sports_pre_1980s)
AND year>=1980 








