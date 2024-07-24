-- Who are the top 5 countries in terms of medals won since 2000?

SELECT  noc, COUNT(medal) as num_medals
FROM athletes_events
WHERE medal IS NOT NULL AND year>=2000
GROUP BY  noc
ORDER BY num_medals DESC
LIMIT 5 







