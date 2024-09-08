------------------------------------------------------------------------------------------------------------------
--------------------------------------------------   ENTITIES   --------------------------------------------------
------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER Localizacao1Mile ON location INSTEAD OF INSERT AS BEGIN
    IF EXISTS(
        SELECT
            1
        FROM
        location L
    INNER JOIN
        inserted l2
    ) ((SQRT((start_latitude*1000000-end_latitude*1000000)^2+(start_longitude*1000000-end_longitude*1000000)^2)/1609)>1)
    BEGIN
        print 'Any two locations must be at least 1-mile distance apart'
        ROLLBACK
    END
END







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
    --WEAK ENTITY?????
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
    --WEAK ENTITY?????
);

create table vhf(
    cni  numeric (12),
    mmsi numeric (9),
    PRIMARY KEY (cni),
    FOREIGN KEY (cni) REFERENCES boat(cni),
    UNIQUE (mmsi)
);


CREATE TABLE location(
    latitude numeric(8,6),
    longitude numeric(9,6),
    name varchar(80) not null,
    PRIMARY KEY (latitude,longitude),
    authority char(3) NOT NULL,
    FOREIGN KEY (authority) REFERENCES country(iso)
    -- No location can exist at the same time in either of the three tables 'marina' 'wharf' 'port'
    -- Any two locations must be at least 1-mile distance apart
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
    duration timestamp NOT NULL ,
    start_latitude decimal(8,6) NOT NULL,
    start_longitude decimal(9,6) NOT NULL,
    end_latitude decimal(8,6) NOT NULL,
    end_longitude decimal(9,6) NOT NULL,
    PRIMARY KEY (start_date,end_date,date),
    FOREIGN KEY (start_date,end_date) REFERENCES schedule(start_date, end_date),
    FOREIGN KEY (start_latitude,start_longitude) REFERENCES location(latitude,longitude),
    FOREIGN KEY (end_latitude,end_longitude) REFERENCES location(latitude,longitude),
    CHECK ((SQRT((start_latitude*1000000-end_latitude*1000000)+SQUARE(start_longitude*1000000-end_longitude*1000000))/1609)>1)
);




------------------------------------------------------------------------------------------------------------------
------------------------------------------------   ASSOCIATIONS   ------------------------------------------------
------------------------------------------------------------------------------------------------------------------

CREATE TABLE reservation(
    id_card numeric(12),
    cni numeric(12),
    start_date timestamp,
    end_date timestamp,
    PRIMARY KEY (id_card,cni,start_date,end_date),
    FOREIGN KEY (id_card) REFERENCES person(id_card),
    FOREIGN KEY (cni) REFERENCES boat(cni),
    FOREIGN KEY (start_date,end_date) REFERENCES schedule(start_date,end_date)

);

--CREATE TABLE trip_from(latitude numeric(8,6),longitude numeric(9,6),primary key(latitude,longitude),foreign key(latitude,longitude) references location(latitude, longitude));
--CREATE TABLE trip_to(latitude numeric(8,6),longitude numeric(9,6),primary key(latitude,longitude),foreign key(latitude,longitude) references location(latitude, longitude));
--CREATE TABLE sail(date timestamp,id_card numeric(12),cni numeric(12),start_date timestamp,end_date timestamp,PRIMARY KEY (date,id_card,cni,start_date,end_date),FOREIGN KEY (date) REFERENCES trip(date),FOREIGN KEY (id_card,cni,start_date,end_date) REFERENCES reservation(id_card,cni,start_date,end_date));
--CREATE TABLE authority();                                     IN TABLES
--CREATE TABLE owns();                                          IN TABLES
--CREATE TABLE registered();                                    IN TABLES
--CREATE TABLE born_in();                                       IN TABLES


------------------------------------------------------------------------------------------------------------------
------------------------------------------------   CONSTRAINTS    ------------------------------------------------
------------------------------------------------------------------------------------------------------------------

--(IC-1) Reservation schedules of a boat must not overlap.
--(IC-2) Trips of a reservation must not overlap.
--(IC-3) Any two locations must be at least 1-mile distance apart.
--(IC-4) Country flags are unique.                                          DONE
--(IC-5) Country names are unique.                                          DONE
--(IC-6) End date of a schedule must be after start date.                   DONE


------------------------------------------------------------------------------------------------------------------
------------------------------------------------   SQL QUERIES    ------------------------------------------------
------------------------------------------------------------------------------------------------------------------

--A. All boats that have been reserved at least once.
--B. All sailors that have reserved boats registered in the country 'Portugal'.
--C. All reservations longer than 5 days.
--D. Name and CNI of all boats registered in 'South Africa' whose owner name ends with 'Rendeiro'.