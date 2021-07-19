--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-cb-alter.sql

--Student ID: 30884128
--Student Name: George Tan Juan Sheng
--Tutorial No: 5

/* Comments for your marker:




*/

/*
Task 3:

Make the listed changes to the "live" database
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (a)
ALTER TABLE centre ADD (
	centre_no_offspg_born NUMBER(5,0) DEFAULT 0
);

COMMENT ON COLUMN centre.centre_no_offspg_born IS
	'The total number of offsprings born at this centre';

-- (b)
ALTER TABLE animal ADD (
	animal_is_alive CHAR(1) DEFAULT 'Y'
);
ALTER TABLE animal ADD CONSTRAINT chk_animal_is_alive CHECK (animal_is_alive in ('Y','N'));

COMMENT ON COLUMN animal.animal_is_alive IS
	'The state of animal whether it is still alive';

UPDATE animal
SET animal_is_alive = 'N'
WHERE animal_id = 11;
commit; 

/*
******* Explain here your selected approach and its advantage/s *********
My selected approach would be to add an extra attribute to the database which records if an animal is still alive.
The attribute would be called animal_is_alive and will be CHAR(1) data type and would be storing either Y/N , which stands for Yes or No. If an animal
dies, we would just access the animal's data and update its animal_is_alive attribute to N from Y. The default value 
of the attribute would be 'Y' as well which indicates that they are alive. From the above SQL command, I picked animal of 
animal_id 11 which was bred in a centre, and assuming it died, we would just set it's animal_is_alive attribute to 'N'.
This would be an appropriate approach as we could easily determine if an animal is still alive or not and update it 
accordingly as we wish, we would also not lose out on important info. If we were to delete the animal's info once it dies, 
we would lose out on important info, for example if the mother of the young dies and we would delete all related data to 
the mother, breeding events of the young would also be deleted (assuming foreign key is on delete cascade for mother_id in 
breeding_event). We can't nullify the data of the mother as well because info like mother_id is required in breeding events. 
Hence, by adding an extra attribute to an animal which records if it is still alive, we can still keep track of the animal's 
young or parents even if it is dead, which makes sense in real life since we are not supposed to lose out on info if an animal 
dies.
*/



-- (c)
DROP TABLE centre_type CASCADE CONSTRAINT PURGE;
CREATE TABLE centre_type(
	centre_type_id      NUMBER(6) NOT NULL,
	centre_type_name    VARCHAR2(30) NOT NULL
);

ALTER TABLE centre_type ADD CONSTRAINT centre_type_pk PRIMARY KEY (centre_type_id);
ALTER TABLE centre_type ADD CONSTRAINT un_centre_type_name UNIQUE (centre_type_name);

COMMENT ON COLUMN centre_type.centre_type_id IS
	'The id referring to the centre type name';

COMMENT ON COLUMN centre_type.centre_type_name IS
	'The centre type name';

ALTER TABLE centre ADD (
	centre_type_id NUMBER(6) 
);

COMMENT ON COLUMN centre.centre_type_id IS
	'The id referring to the centre type name';


ALTER TABLE centre 
	ADD CONSTRAINT fk_centre_type_id FOREIGN KEY (centre_type_id) 
		REFERENCES centre_type (centre_type_id);

DROP SEQUENCE centre_type_id_seq;
CREATE SEQUENCE centre_type_id_seq START WITH 1 INCREMENT BY 1;

INSERT INTO centre_type values(0, 'Other');
INSERT INTO centre_type values(centre_type_id_seq.nextval, 'Zoo');
INSERT INTO centre_type values(centre_type_id_seq.nextval, 'Wildlife Park');
INSERT INTO centre_type values(centre_type_id_seq.nextval, 'Sanctuary');
INSERT INTO centre_type values(centre_type_id_seq.nextval, 'Nature Reserve');
commit;


UPDATE centre
SET centre_type_id = 
CASE
WHEN centre_name LIKE '%Zoo%' 
THEN (SELECT centre_type_id 
	FROM centre_type
	WHERE centre_type_name LIKE '%Zoo%')

WHEN centre_name LIKE '%Park%' 
THEN (SELECT centre_type_id 
	FROM centre_type
	WHERE centre_type_name LIKE '%Park%')

WHEN centre_name LIKE '%Sanctuary%' 
THEN (SELECT centre_type_id 
	FROM centre_type
	WHERE centre_type_name LIKE '%Sanctuary%')

WHEN centre_name LIKE '%Reserve%' 
THEN (SELECT centre_type_id 
	FROM centre_type
	WHERE centre_type_name LIKE '%Reserve%')

ELSE 0
END;
commit;