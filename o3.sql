 -- How does the participation of females after 
-- 1988 compare to participation before 1988?
SELECT  CASE
    WHEN year >= 1988 THEN 'after 1988'
    ELSE 'before 1988'
  END AS time_period,
  Round(
    100.0 * (
      SUM(
        CASE
          WHEN sex = 'F' THEN 1
          ELSE 0
        END
      )
    ) / COUNT(*),
    2
  ) AS percentage_of_females
from
  athletes_events
GROUP BY
  time_period