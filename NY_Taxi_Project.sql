/*The competition dataset is based on the 2016 NYC Yellow Cab trip record data made available in Big Query on Google Cloud Platform. 

The datset contains the following fields:
 
1. Information about the customer and vendor

id : a unique identifier for each trip

vendor_id : a code indicating the provider associated with the trip record

passenger_count : the number of passengers in the vehicle (driver entered value)

2. Information about the Trip

pickup_longitude : date and time when the meter was engaged

pickup_latitude : date and time when the meter was disengaged

dropoff_longitude : the longitude where the meter was disengaged

dropoff_latitude : the latitude where the meter was disengaged

store_and_fwd_flag : This flag indicates whether the trip record was held in vehicle memory before sending 
to the vendor because the vehicle did not have a connection to the server (Y=store and forward; N=not a store and forward trip)

trip_duration : (target) duration of the trip in seconds


*/


--Checking the data

SELECT *   
FROM      dbo.NYC_Taxi

SELECT *   
FROM       dbo.NYC_Taxi
ORDER BY   trip_duration DESC



SELECT     COUNT(*) 
FROM       dbo.NYC_Taxi


SELECT     DISTINCT(passenger_count) 
FROM       dbo.NYC_Taxi



-- Cleaning the Data

-- We drop the values below, since the occurence of such huge or small values is unlikely.
-- These values might exist because of some erros which typically occurs during data collection.


DELETE   FROM dbo.NYC_Taxi
WHERE    trip_duration < 298 



DELETE    FROM dbo.NYC_Taxi
WHERE     trip_duration >7003



SELECT COUNT(*) FROM dbo.NYC_Taxi






-- What are the the best performing months in terms of Number of Pickups and Dropoffs?


-- Number of Pickups done  on each month



SELECT      DATENAME(MONTH,pickup_datetime) AS Month,
            COUNT(*) AS total_pickups
FROM        dbo.NYC_Taxi
GROUP BY    DATENAME(MONTH,pickup_datetime)
ORDER BY    total_pickups  DESC




--Number of Dropoffs done on each month 



SELECT        DATENAME(MONTH,dropoff_datetime) AS Month,
              COUNT(*) AS total_dropoffs
FROM          dbo.NYC_Taxi
GROUP BY      DATENAME(MONTH,dropoff_datetime)
ORDER BY      total_dropoffs  DESC


--All the questions below are for April 2016



-- What is the best performing week of April in terms of Number of Pickups and Dropoffs?


-- Number of Pickups done on each week of April



SELECT         DATEPART(WEEK,pickup_datetime) AS Week_num , --Week of March
               COUNT(*)  AS total_pickups
FROM           dbo.NYC_Taxi
WHERE          pickup_datetime
BETWEEN       '2016-04-01'
AND           '2016-04-30'
GROUP BY       DATEPART(WEEK,pickup_datetime)
ORDER BY       Week_num





--Number of Dropoffs done on each week 



SELECT        DATEPART(WEEK,dropoff_datetime) AS week_num, --Week of April
              COUNT(*)  AS total_dropoffs
FROM          dbo.NYC_Taxi
WHERE         pickup_datetime
BETWEEN       '2016-04-01'
AND           '2016-04-30'
GROUP BY      DATEPART(WEEK,dropoff_datetime)
ORDER BY      Week_num




-- What is the best performing day of week on April, in terms  of Number of Pickups and Dropoffs?


-- Number of Pickups done on each day of week


SELECT		   DATENAME(WEEKDAY,pickup_datetime) AS week_day, -- day of the week
			   COUNT(*) AS total_pickups
FROM		   dbo.NYC_Taxi
WHERE          pickup_datetime
BETWEEN       '2016-04-01'
AND           '2016-04-30'
GROUP BY	   DATENAME(WEEKDAY,pickup_datetime)
ORDER BY       total_pickups DESC



--Number of Dropoffs done on each day of week


SELECT		  DATENAME(WEEKDAY,dropoff_datetime) AS week_day, -- day of the week
			  COUNT(*) AS total_rides
FROM		  dbo.NYC_Taxi
WHERE         pickup_datetime
BETWEEN       '2016-04-01'
AND           '2016-04-30'
GROUP BY	  DATENAME(WEEKDAY,dropoff_datetime)
ORDER BY      total_rides DESC




--Number of Pickups Per Timezone on each day of week


SELECT	     DATENAME(WEEKDAY,pickup_datetime) AS Weekday,
             COUNT(*) AS Total_Pickups,
			 SUM(CASE WHEN DATEPART(HOUR,pickup_datetime) BETWEEN 0 AND 5 THEN 1 ELSE 0 END) AS 'Late Night - (00-06)' ,
			 SUM(CASE WHEN DATEPART(HOUR,pickup_datetime) BETWEEN 6 AND 11 THEN 1 ELSE 0 END) AS 'Morning - (06-12)' ,
			 SUM(CASE WHEN DATEPART(HOUR,pickup_datetime) BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS 'Midday- (12-18)' ,
			 SUM(CASE WHEN DATEPART(HOUR,pickup_datetime) BETWEEN 18 AND 23 THEN 1 ELSE 0 END) AS 'Evening - (18-24)' 
FROM         dbo.NYC_Taxi
WHERE        pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY     DATENAME(WEEKDAY,pickup_datetime)
ORDER BY     Total_Pickups  DESC



--Number of Dropoffs Per Timezone on each day of week

SELECT	     DATENAME(WEEKDAY,dropoff_datetime) AS Weekday,
             COUNT(*) AS Total_Dropoffs,
			 SUM(CASE WHEN DATEPART(HOUR,dropoff_datetime) BETWEEN 0 AND 5 THEN 1 ELSE 0 END) AS 'Late Night - (00-06)' ,
			 SUM(CASE WHEN DATEPART(HOUR,dropoff_datetime) BETWEEN 6 AND 11 THEN 1 ELSE 0 END) AS 'Morning - (06-12)' ,
			 SUM(CASE WHEN DATEPART(HOUR,dropoff_datetime) BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS 'Midday- (12-18)' ,
			 SUM(CASE WHEN DATEPART(HOUR,dropoff_datetime) BETWEEN 18 AND 23 THEN 1 ELSE 0 END) AS 'Evening - (18-24)' 
FROM         dbo.NYC_Taxi
WHERE        pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY     DATENAME(WEEKDAY,dropoff_datetime)
ORDER BY     Total_Dropoffs  DESC



--Which is the busiest time of day in terms of Pickups?


--Number of Pickups Per Hour


SELECT          DATEPART(HOUR,pickup_datetime) AS Hour,
                COUNT(*) AS Total_Rides
FROM            dbo.NYC_Taxi
WHERE           pickup_datetime
BETWEEN        '2016-04-01'
AND            '2016-04-30'
GROUP BY        DATEPART(HOUR,pickup_datetime)
ORDER BY        Hour




-- Relationship between passengers and Trips



SELECT       COUNT(*) AS Trips,
	         passenger_count
FROM         dbo.NYC_Taxi
WHERE        pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY     passenger_count
ORDER BY     Trips  DESC




-- Relationship between vendor_id and Trips



SELECT       COUNT(*) AS Trips,
	         vendor_id
FROM         dbo.NYC_Taxi
WHERE        pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY     vendor_id
ORDER BY     Trips  DESC



--Relationship between vendor_id and  Trip duration


SELECT        vendor_id,
              COUNT(trip_duration) AS Total_Trip_duration 
FROM          dbo.NYC_Taxi
WHERE         pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY      vendor_id



--Relationship between store forward flag and trips



SELECT       COUNT(*) AS Trips,
             store_and_fwd_flag      
FROM         dbo.NYC_Taxi
WHERE        pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY     store_and_fwd_flag





--Average Trip Duration Per Day of Week
-- Convert seconds to minutes



SELECT        DATENAME(WEEKDAY,pickup_datetime) AS Day,
              ROUND(AVG(trip_duration/60.0),2) AS Avg_trip_dur
FROM          dbo.NYC_Taxi
WHERE         pickup_datetime
BETWEEN       '2016-04-01'
AND           '2016-04-30'
GROUP BY      DATENAME(WEEKDAY,pickup_datetime)
ORDER BY      Avg_trip_dur DESC
              
              


-- When do Trips take the longest?
--Average Trip duration by hour
--Convert seconds to minutes



SELECT          DATEPART(HOUR,pickup_datetime) AS Hour,
                ROUND(AVG(trip_duration/60.0),2) AS Avg_Trip_Duration
FROM            dbo.NYC_Taxi
WHERE           pickup_datetime
BETWEEN         '2016-04-01'
AND             '2016-04-30'
GROUP BY        DATEPART(HOUR,pickup_datetime)
ORDER BY        Hour




-- What are the most popular points in terms of pickups, with minimum number of rides being 2? 


SELECT	     vendor_id,
             pickup_latitude,
			 pickup_longitude,
			 COUNT(*) AS Rides
FROM         dbo.NYC_Taxi
WHERE        pickup_datetime
BETWEEN      '2016-04-01'
AND          '2016-04-30'
GROUP BY     pickup_latitude,
             pickup_longitude,
			 vendor_id
HAVING       COUNT(*) >=2
ORDER BY     Rides DESC



         
		 

 