

--(IC-1) Two reservations for the same boat can not have their corresponding date intervals intersecting.

CREATE OR REPLACE FUNCTION msgfailerror()
RETURNS trigger AS
$$
  DECLARE
    nb int;
BEGIN
select  count(*) into nb from reservation where (New.start_date BETWEEN start_date AND end_date)or(New.end_date BETWEEN start_date AND end_date);
if (nb >0) then
RAISE EXCEPTION 'this boat is reserving';
END IF;
  return new;
END;
$$
LANGUAGE plpgsql;

create trigger res_check
before insert ON  reservation
for each row execute procedure msgfailerror();

--(IC-2) Any location must be specialized in one of three-disjoint - entities: marina, wharf, or port.
create or replace function bi_marina_2()
returns trigger AS
$$
DECLARE
	v_marina int;
BEGIN
	select  count(*)
    into    v_marina
    from    location
    where   latitude = NEW.latitude
    and     longitude = NEW.longitude;

    if (v_marina = 0) then
		raise exception 'location is not specialized on any entity';
    end if;

	return new;
end;$$
LANGUAGE plpgsql;

create trigger bi_marina_trg_2
BEFORE INSERT ON marina
FOR EACH ROW
EXECUTE PROCEDURE bi_marina_2();




create or replace function bi_wharf_2()
returns trigger AS
$$
DECLARE
	v_wharf int;
BEGIN
	select  count(*)
    into    v_wharf
    from    location
    where   latitude = NEW.latitude
    and     longitude = NEW.longitude;

    if (v_wharf = 0) then
		raise exception 'location is not specialized on any entity';
    end if;

	return new;
end;$$
LANGUAGE plpgsql;

create trigger bi_wharf_trg_2
BEFORE INSERT ON wharf
FOR EACH ROW
EXECUTE PROCEDURE bi_wharf_2();



create or replace function bi_port_2()
returns trigger AS
$$
DECLARE
	v_port int;
BEGIN
	select  count(*)
    into    v_port
    from    location
    where   latitude = NEW.latitude
    and     longitude = NEW.longitude;

    if (v_port = 0) then
		raise exception 'location is not specialized on any entity';
    end if;

	return new;
end;$$
LANGUAGE plpgsql;

create trigger bi_port_trg_2
BEFORE INSERT ON port
FOR EACH ROW
EXECUTE PROCEDURE bi_port_2();



--(IC-3)  A country where a boat is registered must correspond - at least - to one location.

CREATE OR REPLACE FUNCTION bi_boat_3()
RETURNS trigger AS
$$
DECLARE
    v_count int;
BEGIN
	select  count(*)
	into 	v_count
	from 	location l, country c
	where 	New.iso_code = c.iso_code
	and 	l.iso_code = c.iso_code;

	if (v_count = 0) then
		RAISE EXCEPTION 'at least one location';
	END IF;

	return new;
END;
$$
LANGUAGE plpgsql;

create trigger bi_boat_trg_3
BEFORE INSERT ON boat
FOR EACH ROW
EXECUTE PROCEDURE bi_boat_3();



