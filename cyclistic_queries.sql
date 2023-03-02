  --Combining all table data into one
WITH
  combined_tables_2022 AS (
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Jan_Data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Feb_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Mar_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Apr_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_May_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Jun_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Jul_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Aug_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Sep_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Oct_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Nov_data`
  UNION ALL
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM
    `cyclisticdataanalysis-377116.Trips202201.2022_Dec_data` )
SELECT
  *
FROM
  combined_tables_2022
  --Checking for misspellings
SELECT
  DISTINCT member_casual,
  rideable_type
FROM
  `cyclisticdataanalysis-377116.Trips202201.2022_Jan_Data`
  --Calculate ride_length in minutes
UPDATE
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
SET
  ride_length = TIMESTAMP_DIFF(ended_at, started_at, MINUTE)
WHERE
  TRUE
  --Extract day of the week from started_at
UPDATE
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
SET
  day_of_the_week = CAST(EXTRACT(DAYOFWEEK
    FROM
      started_at) AS STRING)
WHERE
  TRUE
  -- --Extract month from ride start date
UPDATE
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
SET
  month = CAST(EXTRACT(month
    FROM
      started_at) AS STRING)
WHERE
  TRUE
  --Check where ride length is negative
SELECT
  *
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022` AS combined_data
WHERE
  ride_length <= 0
  --Remove those rows
DELETE
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022` AS combined_data
WHERE
  ride_length <= 0
  -- --Select all users who have bikes more than 24 hours before returning
SELECT
  member_casual,
  COUNT(member_casual) AS total_riders,
  AVG(ride_length/1440) AS Average_Ride_length,
  --in days
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022` AS combined_data
WHERE
  ride_length > 1440
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
GROUP BY
  member_casual
  --Select all users who have bikes less than 24 hours before returning
SELECT
  member_casual,
  COUNT(member_casual) AS total_riders,
  AVG(ride_length) AS Average_Ride_length,
  --in minutes
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022` AS combined_data
WHERE
  ride_length < 1440
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
GROUP BY
  member_casual
  --Total riders based on months in a year
SELECT
  COUNT(member_casual) AS total_riders,
  FORMAT_DATE('%B', started_at) AS month
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
GROUP BY
  month
ORDER BY
  month
  --Total casual  riders based on months of year
SELECT
  COUNT(member_casual) AS total_riders,
  FORMAT_DATE('%B', started_at) AS month
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
WHERE
  member_casual = "casual"
GROUP BY
  month
ORDER BY
  month
  --Total member riders based on day of week
SELECT
  COUNT(member_casual) AS total_riders,
  FORMAT_DATE('%A', started_at) AS day_of_week
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
WHERE
  member_casual = "member"
GROUP BY
  day_of_week
  --ORDER BY day_of_week
  --Query to see how many member riders start at differnt startions
SELECT
  COUNT(*) AS riders,
  start_station_name,
  ROUND(AVG(start_lat), 2) AS lat,
  ROUND(AVG(start_lng), 2) AS lng
FROM
  `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
WHERE
  member_casual = "member"
  AND start_station_name IS NOT NULL
  AND end_lat IS NOT NULL
  AND end_lat IS NOT NULL
GROUP BY
  start_station_name
ORDER BY
  riders DESC
  --Pecentage of member vs casual riders in the dataset
SELECT
  DISTINCT member_casual,
  100*(member_casual_tot / total) AS percentage_of_riders
FROM (
  SELECT
    DISTINCT member_casual,
    COUNT(*) AS member_casual_tot,
    SUM(COUNT(*)) OVER() AS total
  FROM
    `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
  GROUP BY
    member_casual )
  --Pecentage of bikes preffered by members
SELECT
  DISTINCT rideable_type,
  100*(rideable_type_total / total) AS percentage_of_bikes_used
FROM (
  SELECT
    DISTINCT rideable_type,
    COUNT(*) AS rideable_type_total,
    SUM(COUNT(rideable_type)) OVER() AS total
  FROM
    `cyclisticdataanalysis-377116.Trips202201.combined_bike_data_2022`
  GROUP BY
    rideable_type )
