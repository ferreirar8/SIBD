CREATE OR REPLACE VIEW trip_info (country_iso_origin,country_name_origin,country_iso_dest,country_name_dest,loc_name_origin,loc_name_dest,cni_boat,country_iso_boat,country_name_boat,trip_start_date) AS
SELECT (select iso_code from location join trip on (location.latitude=trip.start_latitude and location.longitude=trip.start_longitude)),(select name from country where iso_code=(select iso_code from location join trip on (location.latitude=trip.start_latitude and location.longitude=trip.start_longitude))),
(select iso_code from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude)),(select name from country where iso_code=(select iso_code from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude))),
(select name from location join trip on (location.latitude=trip.start_latitude and location.longitude=trip.start_longitude)),
(select name from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude)),
(select cni from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude)),
(select iso_code_boat from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude)),
(select name from country where country.iso_code=(select iso_code_boat from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude))),
(select start_date from location join trip on (location.latitude=trip.end_latitude and location.longitude=trip.end_longitude));

 select * from trip_info;
