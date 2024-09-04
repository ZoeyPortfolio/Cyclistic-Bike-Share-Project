SELECT 
	rideable_type,
	FORMAT(started_at, 'MMMM') AS MonthName,
	CONVERT(VARCHAR(5), started_at, 108) AS started_time,
    CONVERT(VARCHAR(5), 
        CASE 
            WHEN DATEPART(MINUTE, started_at) >= 30 THEN 
                DATEADD(HOUR, 1, DATEADD(MINUTE, -DATEPART(MINUTE, started_at), started_at))
            ELSE 
                DATEADD(MINUTE, -DATEPART(MINUTE, started_at), started_at)
        END, 108) AS rounded_time,
	DATEPART(HOUR, started_at) + (DATEPART(MINUTE, started_at) / 60.0) AS time_in_hours,
	DATENAME(weekday,started_at) As day_of_week,
	DATEDIFF(SECOND, 0, CAST(ended_at - started_at AS time))/60.0 AS ride_length,
	member_casual
INTO tripdata_cleaned_03
FROM [GoogleAnalytics].[dbo].[tripdata_202403]