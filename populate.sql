alter table trip
    drop constraint trip_cni_fkey;

alter table trip
    add constraint trip_cni_fkey
        foreign key (cni, iso_code_boat, id_sailor, iso_code_sailor, start_date, end_date) references reservation
            on delete cascade;


alter table owner
    drop constraint owner_id_fkey;

alter table owner
    add constraint owner_id_fkey
        foreign key (id, iso_code) references person
            on delete cascade;

alter table sailor
    drop constraint sailor_id_fkey;

alter table sailor
    add constraint sailor_id_fkey
        foreign key (id, iso_code) references person
            on delete cascade;

alter table reservation
    drop constraint reservation_id_sailor_fkey;

alter table reservation
    add constraint reservation_id_sailor_fkey
        foreign key (id_sailor, iso_code_sailor) references sailor
            on delete cascade;

alter table boat
    drop constraint boat_iso_code_fkey;

alter table boat
    add foreign key (iso_code) references country
        on delete cascade;

alter table boat
    drop constraint boat_id_owner_fkey;

alter table boat
    add constraint boat_id_owner_fkey
        foreign key (id_owner, iso_code_owner) references owner
            on delete cascade;

alter table reservation
    drop constraint reservation_cni_fkey;

alter table reservation
    add constraint reservation_cni_fkey
        foreign key (cni, iso_code_boat) references boat
            on delete cascade;

alter table boat_vhf
    drop constraint boat_vhf_cni_fkey;

alter table boat_vhf
    add constraint boat_vhf_cni_fkey
        foreign key (cni, iso_code) references boat
            on delete cascade;

alter table boat
    alter column id_owner set default NULL;

alter table boat
    alter column iso_code_owner set default NULL;
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO country VALUES('PT', 'Portugal', 'PT');
INSERT INTO country VALUES('ZF', 'South Africa', 'ZF');
INSERT INTO country VALUES('AG', 'Afghanistan', 'AG');
INSERT INTO country VALUES('FA', 'France', 'FA');
INSERT INTO country VALUES('JN', 'Japan', 'JN');
INSERT INTO country VALUES('MX', 'Mexico', 'MX');
INSERT INTO country VALUES('ME', 'Montenegro', 'ME');
INSERT INTO country VALUES('NR', 'Norway', 'NR');
INSERT INTO country VALUES('UA', 'United States of America', 'UA');
INSERT INTO country VALUES('GR', 'United Kingdom of Great Britain and Northern Ireland','GR');

INSERT INTO person VALUES('157347413210', 'Burzin Kurush Dil','AG');
INSERT INTO person VALUES('157347413211', 'Jules Laurent Rendeiro Benett','FA');
INSERT INTO person VALUES('157347413212', 'Yakushimaru Morimasa Sugano Washichi','JN');
INSERT INTO person VALUES('157347413213', 'Jonny Matrecos','FA');
INSERT INTO person VALUES('157347413214', 'Juan Manuel Santolaria Sergi Arroyo Yago','MX');
INSERT INTO person VALUES('157347413215', 'Mahaman Bachar Moustapha','ME');
INSERT INTO person VALUES('157347413216', 'Mansoor al-Karam Burhaan el-Ismael','AG');
INSERT INTO person VALUES('157347413217', 'Pinto Rendeiro Rolando','PT');
INSERT INTO person VALUES('157347413218', 'Manus Rendeiro','ZF');
INSERT INTO person VALUES('157347413219', 'Manus Filipe Rendeira','ZF');
INSERT INTO person VALUES('157347413220', 'Mads Christoffersen Paasche Thon','NR');
INSERT INTO person VALUES('157347413221', 'Hampton Burton Anthony Rendeiro','UA');
INSERT INTO person VALUES('157347413222', 'Samantha Rendeiro Watts','GR');
INSERT INTO person VALUES('157347413223', 'Roselyne Prudhomme Trintignant','FA');
INSERT INTO person VALUES('157347413224', 'Rui Josefina','PT');
INSERT INTO person VALUES('157347413225', 'Marcia Rodrigues','FA');

INSERT INTO owner VALUES('157347413212','JN', '1980-12-19');
INSERT INTO owner VALUES('157347413216','AG', '1994-08-05');
INSERT INTO owner VALUES('157347413217','PT', '1999-10-01');
INSERT INTO owner VALUES('157347413218','ZF', '1999-10-01');
INSERT INTO owner VALUES('157347413219','ZF', '1999-10-01');
INSERT INTO owner VALUES('157347413220','NR', '1998-08-19');
INSERT INTO owner VALUES('157347413221','UA', '1960-07-15');
INSERT INTO owner VALUES('157347413223','FA', '1985-01-20');
INSERT INTO owner VALUES('157347413224','PT', '1998-07-22');
INSERT INTO owner VALUES('157347413225','FA', '1994-12-25');

INSERT INTO sailor VALUES('157347413213','FA');
INSERT INTO sailor VALUES('157347413218','ZF');
INSERT INTO sailor VALUES('157347413210','AG');
INSERT INTO sailor VALUES('157347413211','FA');
INSERT INTO sailor VALUES('157347413214','MX');
INSERT INTO sailor VALUES('157347413215','ME');
INSERT INTO sailor VALUES('157347413221','UA');
INSERT INTO sailor VALUES('157347413222','GR');
INSERT INTO sailor VALUES('157347413219','ZF');
INSERT INTO sailor VALUES('157347413220','NR');

INSERT INTO location VALUES('Port of Los Angeles','33.73','-118.2625','UA');
INSERT INTO location VALUES('Mole des Trois Maries','41.923975','8.741167','FA');
INSERT INTO location VALUES('Portonovi','42.435286','18.598569','ME');
INSERT INTO location VALUES('Cabo Rojo','21.725156','-97.558912','MX');
INSERT INTO location VALUES ('Lisbon', '39.557191','-7.8536599' , 'PT');
INSERT INTO location VALUES ('Pretoria', '-28.4792625', '24.6727135', 'ZF');
INSERT INTO location VALUES ('Kabul', '33.9340384', '67.7034313', 'AG');
INSERT INTO location VALUES ('Toquio', '37.4900318', '136.4664008', 'JN');
INSERT INTO location VALUES ('Londo', '51.50853', '-0.12574', 'GR');
INSERT INTO location VALUES('Porto de Sines','35.575156','8.538912','PT');


INSERT INTO boat VALUES('Pinta', '2005', '309796789414', 'PT','157347413217','PT');
INSERT INTO boat VALUES('Galeao', '2005', '309796789415', 'PT','157347413217','PT');
INSERT INTO boat VALUES('Marco', '2005', '309796789416', 'ZF', '157347413218','ZF');
INSERT INTO boat VALUES('Marca', '2005', '309796789417', 'ZF', '157347413219','ZF');
INSERT INTO boat VALUES('Titanic', '2000', '309796789418', 'AG','157347413212','JN');
INSERT INTO boat VALUES('Queen Elizabeth', '2012', '309796789419', 'FA', '157347413216','AG');
INSERT INTO boat VALUES('Kamikaze', '2021', '309796789420', 'JN', '157347413216','AG');
INSERT INTO boat VALUES('Lusitania', '2020', '309796789421', 'PT', '157347413220','NR');
INSERT INTO boat VALUES('Constant Warwick', '2018', '309796789424', 'UA','157347413221','UA');
INSERT INTO boat VALUES('Esperanza', '2008', '309796789422', 'MX', '157347413223','FA');
INSERT INTO boat VALUES('Northern Rover', '2010', '309796789423', 'ME', '157347413223','FA');
INSERT INTO boat VALUES('Black Rose', '2019', '309796789415', 'MX','157347413217','PT');


INSERT INTO schedule VALUES('2021-06-15', '2021-06-18');
INSERT INTO schedule VALUES('2021-12-16', '2022-01-02');
INSERT INTO schedule VALUES('2021-07-15', '2021-07-18');
INSERT INTO schedule VALUES('2021-08-16', '2021-09-02');
INSERT INTO schedule VALUES('2021-09-15', '2021-10-18');
INSERT INTO schedule VALUES('2021-10-16', '2022-01-01');
INSERT INTO schedule VALUES('2021-10-19', '2021-11-18');


INSERT INTO reservation VALUES('309796789414','PT','157347413213','FA','2021-06-15', '2021-06-18');
INSERT INTO reservation VALUES('309796789416','ZF','157347413218','ZF','2021-12-16', '2022-01-02');
INSERT INTO reservation VALUES('309796789424','UA','157347413219','ZF','2021-07-15', '2021-07-18');
INSERT INTO reservation VALUES('309796789422','MX','157347413220','NR','2021-08-16', '2021-09-02');
INSERT INTO reservation VALUES('309796789418','AG','157347413215','ME','2021-09-15', '2021-10-18');
INSERT INTO reservation VALUES('309796789418','AG','157347413215','ME','2021-10-19', '2021-11-18');


INSERT INTO port VALUES('33.73','-118.2625');

INSERT INTO marina VALUES('42.435286','18.598569');

INSERT INTO wharf VALUES('41.923975','8.741167');


INSERT INTO boat_vhf VALUES ('915478263','309796789414','PT');
INSERT INTO boat_vhf VALUES ('287546125','309796789419','FA');
INSERT INTO boat_vhf VALUES ('216478965','309796789420','JN');

INSERT INTO trip VALUES ('2021-01-01','30','309796789418','AG','157347413215','ME','2021-10-19','2021-11-18','42.435286', '18.598569','35.575156','8.538912');