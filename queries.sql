--3. SQL


create or replace view bt as
 select owner.id,owner.iso_code,count(boat.id_owner) as nb from  owner  join country on country.iso_code=owner.iso_code
 join boat on boat.id_owner=owner.id group by owner.id,owner.iso_code;

--1) Who is the owner with the most boats per country
select distinct (iso_code),id,max(nb) from bt group by id,iso_code;

 
 --2)List all the owners that have at least two boats in distinct countries.
 
  select owner.id,count(*) from  owner
 join boat on boat.id_owner=owner.id group by owner.id having count(distinct boat.iso_code)>=2;
 
 
 --3) Who are the sailors that have sailed to every location in Portugal
  select sailor.id,count(sailor.iso_code)  from  sailor
 join person on sailor.id=person.id  join country on country.iso_code=person.iso_code
 join location on location.iso_code=country.iso_code group by sailor.id having count(sailor.iso_code)=(select count(*) from location where location.iso_code='PT');
 

 --4) List the sailors with the most trips along with their reservations
 
   select sailor.id, count(reservation) from  sailor
 join trip on trip.id_sailor =sailor.id  
 join reservation on reservation.id_sailor =sailor.id  group by sailor.id order by sailor.id desc;
 
 --5)List the sailors with the longest duration of trips (sum of trip durations) for the same
--single reservation; display also the sum of the trip durations.

 select sailor.id,sum(trip.end_date-trip.start_date) as duration_in_days from  sailor
 join trip on trip.id_sailor =sailor.id  
 join reservation on reservation.id_sailor =sailor.id group by sailor.id;