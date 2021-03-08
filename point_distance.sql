use RAS_APR_Reconciliation
drop table dbo.practice_table
drop table ##temp_results

---Create and setup table
---I added a new column "point" with a geography datatype. I'll use the provided Lat/Lon to fill out this field.
---Note there is only 1 duplicate name "Place F"


CREATE TABLE practice_table (
    unique_id varchar(250),
    name varchar(250),
    type varchar(250),
    latitude double precision,
    longitude double precision,
    geom text,
	point geography
);


insert into dbo.practice_table(unique_id,name,type,latitude,longitude,geom) values
('123456789','Place A  ','Neighborhood','49.5752022','7.2221923','WKB'),
('123456788','Place B  ','Village','52.215854','13.4429409','WKB'),
('123456787','Place C  ','Neighborhood','51.4332589','6.7654771','WKB'),
('123456786','Place D  ','Village','51.5151763','7.258586','WKB'),
('123456785','Place E  ','Neighborhood','51.9501142','9.9139558','WKB'),
('123456784','Place F  ','Village','49.0655296','11.885638','WKB'),
('123456783','Place F  ','Neighborhood','50.7472277','6.4882763','WKB'),
('123456782','Place H  ','City','54.2253662','9.223169','WKB'),
('123456781','Place I  ','Town','53.9180666','9.0485997','WKB'),
('123456780','Place J  ','Region','53.5306132','9.1682787','WKB')



---create the WKB Byte-String as a geography datatype for a point
UPDATE a
SET point = GEOGRAPHY::Point(latitude, longitude, 4326)
FROM dbo.practice_table a;


----CTE and cross apply query to get a source ID and point for every combination of places
----Could be performance concerns here
----Not bad with only ten records which results in 100 different combinations

WITH base
AS (
	SELECT unique_id
		,name
		,point
		,type
	FROM dbo.practice_table
	)
	,dist
AS (
	SELECT base.unique_id AS srce_id
		,base.name AS srce_name
		,base.point AS srce_point
		,base.type as srce_type
		,dist.unique_id AS dist_id
		,dist.name AS dist_name
		,base.point.STDistance(GEOGRAPHY::Point(dist.latitude, dist.longitude, 4326)) / 1000 AS DistInKM
	FROM base
	CROSS APPLY dbo.practice_table AS dist
	)
SELECT 
ROW_NUMBER() over (partition by srce_id order by distinkm asc) as indx
,srce_id
,srce_name
,srce_type
,dist_id
,dist_name
,DistInKM
into ##temp_results
FROM dist


---Main Question
---In this data set, a pair of "duplicates" is defined as two different places that have the exact same name and whose map labels are less than 5km from each other.
---Per the above criteria there are no duplicates. There is only one name duplicated "Place F" and they are 430 KM apart  
---must have same name but different id

Select 
srce_id as 'unique_id'
,srce_name as'name'
,srce_type as type  
from  ##temp_results
where srce_name = dist_name
and srce_id <> dist_id
and DistInKM < 5


-----Bonus info
-----What is the next closet point to all 10 places that isn't itself.
select * 
from  ##temp_results
where srce_id <> dist_id
and indx = 2 
order by srce_name
