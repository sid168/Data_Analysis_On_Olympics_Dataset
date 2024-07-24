-- How many sports appeared in the Summer Olympics each year?

SELECT year, COUNT(DISTINCT sport) FROM athletes_events
WHERE season='Summer'
GROUP BY year









