drop table if exists sailor cascade;
drop table if exists vhf cascade;
drop table if exists marina cascade;
drop table if exists wharf cascade;
drop table if exists port cascade;
drop table if exists trip cascade;
drop table if exists location cascade;
drop table if exists reservation cascade;
drop table if exists boat cascade;
drop table if exists owner cascade;
drop table if exists person cascade;
drop table if exists country cascade;
drop table if exists schedule cascade;

CREATE TABLE country(
    iso char(3),
    name varchar(70) NOT NULL ,
    flag varchar(3) NOT NULL ,
    PRIMARY KEY (iso),
    UNIQUE (name),
    UNIQUE (flag)
);

CREATE TABLE person(
    born_in char(3),
    id_card numeric(12),
    name varchar(80),
    PRIMARY KEY (born_in,id_card),
    FOREIGN KEY (born_in) REFERENCES country(iso),
    UNIQUE (id_card)
    --  Every person must exist either in the table 'sailor' or in the table 'owner'
);

CREATE TABLE sailor(
    id_card numeric(12),
    PRIMARY KEY (id_card),
    FOREIGN KEY (id_card) REFERENCES person(id_card),
    UNIQUE (id_card)
);

CREATE TABLE owner(
    id_card numeric(12),
    birthdate date not null,
    PRIMARY KEY (id_card),
    FOREIGN KEY (id_card) REFERENCES person(id_card),
    UNIQUE (id_card)
);

CREATE TABLE boat(
    iso char(3),
    cni numeric(12),
    year numeric(4),
    name varchar(80),
    length numeric(12),
    owned_by numeric(12) NOT NULL,
    PRIMARY KEY (iso, cni),
    FOREIGN KEY (iso) REFERENCES country(iso),
    FOREIGN KEY (owned_by) REFERENCES owner(id_card),
    UNIQUE (cni)
);

CREATE TABLE vhf(
    cni  numeric (12),
    mmsi numeric (9),
    PRIMARY KEY (cni),
    FOREIGN KEY (cni) REFERENCES boat(cni),
    UNIQUE (mmsi)
);

CREATE TABLE location(
    latitude numeric(8,6),
    longitude numeric(9,6),
    name varchar(80) NOT NULL,
    PRIMARY KEY (latitude,longitude),
    authority char(3) NOT NULL,
    FOREIGN KEY (authority) REFERENCES country(iso)
    -- No location can exist at the same time in either of the three tables 'marina' 'wharf' 'port'
    --(IC-3) Any two locations must be at least 1-mile distance apart.

);

CREATE TABLE marina(
    latitude decimal(8,6),
    longitude decimal(9,6),
    PRIMARY KEY (latitude,longitude),
    FOREIGN KEY (latitude,longitude) REFERENCES location(latitude, longitude)
);

CREATE TABLE wharf(
    latitude decimal(8,6),
    longitude decimal(9,6),
    PRIMARY KEY (latitude,longitude),
    FOREIGN KEY (latitude,longitude) REFERENCES location(latitude, longitude)
);

CREATE TABLE port(
    latitude decimal(8,6),
    longitude decimal(9,6),
    PRIMARY KEY (latitude,longitude),
    FOREIGN KEY (latitude,longitude) REFERENCES location(latitude, longitude)
);

CREATE TABLE schedule(
    start_date timestamp,
    end_date timestamp,
    CHECK (end_date>start_date),
    PRIMARY KEY (start_date,end_date)
);

CREATE TABLE trip(
    start_date timestamp,
    end_date timestamp,
    date timestamp,
    duration interval NOT NULL ,
    start_latitude decimal(8,6) NOT NULL,
    start_longitude decimal(9,6) NOT NULL,
    end_latitude decimal(8,6) NOT NULL,
    end_longitude decimal(9,6) NOT NULL,
    PRIMARY KEY (start_date,end_date,date),
    FOREIGN KEY (start_date,end_date) REFERENCES schedule(start_date, end_date),
    FOREIGN KEY (start_latitude,start_longitude) REFERENCES location(latitude,longitude),
    FOREIGN KEY (end_latitude,end_longitude) REFERENCES location(latitude,longitude)
    --(IC-2) Trips of a reservation must not overlap.
);

CREATE TABLE reservation(
    id_card numeric(12),
    cni numeric(12),
    start_date timestamp,
    end_date timestamp,
    PRIMARY KEY (id_card,cni,start_date,end_date),
    FOREIGN KEY (id_card) REFERENCES person(id_card),
    FOREIGN KEY (cni) REFERENCES boat(cni),
    FOREIGN KEY (start_date,end_date) REFERENCES schedule(start_date,end_date)
    --(IC-1) Reservation schedules of a boat must not overlap.

);