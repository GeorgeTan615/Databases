--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-cb-dm.sql

--Student ID: 30884128	
--Student Name:George Tan Juan Sheng
--Tutorial No:5

/* Comments for your marker:




*/

/*
Task 2 (c):

Complete the listed DML actions
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (i)
DROP SEQUENCE animal_id_seq;
DROP SEQUENCE brevent_id_seq;

CREATE SEQUENCE animal_id_seq START WITH 500 INCREMENT BY 1;
CREATE SEQUENCE brevent_id_seq START WITH 500 INCREMENT BY 1;



-- (ii)
UPDATE animal
SET centre_id = (SELECT centre_id
		 FROM centre
		 WHERE centre_name = 'Kruger National Park')
WHERE centre_id = (SELECT centre_id
		   FROM centre
		   WHERE centre_name = 'SanWild Wildlife Sanctuary');


DELETE FROM centre
WHERE centre_name = 'SanWild Wildlife Sanctuary';
commit;


-- (iii)
INSERT into animal values(animal_id_seq.nextval,'F', NULL, 
(SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo'), 
(SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'), 
(SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil'));
commit;

INSERT into animal values(animal_id_seq.nextval,'M', NULL, 
(SELECT centre_id FROM centre WHERE centre_name = 'Werribee Open Range Zoo'), 
(SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'), 
(SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil'));
commit;




-- (iv)
INSERT into breeding_event values(brevent_id_seq.nextval, to_date('10-Feb-2021','DD-MON-YYYY'), 
(SELECT animal_id FROM animal WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo') AND 
spec_genus = (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil')), 
(SELECT animal_id FROM animal WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Werribee Open Range Zoo') AND 
spec_genus = (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil')));
commit;


INSERT into animal values(animal_id_seq.nextval,'F', 
(SELECT brevent_id FROM breeding_event WHERE brevent_date = to_date('10-Feb-2021','DD-MON-YYYY') AND 
father_id = (SELECT animal_id FROM animal WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Werribee Open Range Zoo') AND 
spec_genus = (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'))), 
(SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo'), 
(SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'), 
(SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil'));

INSERT into animal values(animal_id_seq.nextval,'M', 
(SELECT brevent_id FROM breeding_event WHERE brevent_date = to_date('10-Feb-2021','DD-MON-YYYY') AND 
father_id = (SELECT animal_id FROM animal WHERE centre_id = (SELECT centre_id FROM centre WHERE centre_name = 'Werribee Open Range Zoo') AND 
spec_genus = (SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'))), 
(SELECT centre_id FROM centre WHERE centre_name = 'Australia Zoo'), 
(SELECT spec_genus FROM species WHERE spec_popular_name = 'Tasmanian Devil'), 
(SELECT spec_name FROM species WHERE spec_popular_name = 'Tasmanian Devil'));
commit;