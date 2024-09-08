 --6
 --The start date
SELECT EXTRACT(DAY from trip_start_date) as day,EXTRACT(MONTH from trip_start_date) as month,EXTRACT(YEAR from trip_start_date) as year, COUNT(*)
FROM trip_info
GROUP BY CUBE (year,month,day) ;

 --The location of origin
SELECT country_iso_origin as country, loc_name_origin as local, count (*) as total
FROM trip_info
GROUP BY ROLLUP (country,local) ;


