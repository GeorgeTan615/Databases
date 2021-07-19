--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-cb-insert.sql

--Student ID: 30884128
--Student Name:George Tan Juan Sheng
--Tutorial No:5

/* Comments for your marker:




*/

/*
Task 2 (b):

Load the ANIMAL and BREEDING_EVENT tables with your own test data using the 
supplied T2-cb-insert.sql file script file, and SQL commands which will  
insert as a minimum, the following sample data -
 - 12 animals, some of which must have been captured from the wild, i.e. 
      are not the offspring from a breeding event, and
- 4 breeding events
Your inserted rows must meet the assignment specification requirements
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

INSERT into animal values(1, 'M', NULL, 'AUS30', 'Sarcophilus','harrisii');
INSERT into animal values(2, 'F', NULL, 'AUS10', 'Diceros','bicornis');

INSERT into animal values(3, 'F', NULL, 'AUS20', 'Acinonyx','jubatus');
INSERT into animal values(4, 'M', NULL, 'SAF10', 'Acinonyx','jubatus');
INSERT into breeding_event values(20, '05-Jan-2020', 3, 4);
INSERT into animal values(5, 'M', 20, 'SAF20', 'Acinonyx','jubatus');

INSERT into animal values(6, 'F', NULL, 'AUS40', 'Panthera','leo');
INSERT into animal values(7, 'M', NULL, 'AUS10', 'Panthera','leo');
INSERT into breeding_event values(25, '06-Jun-2020', 6, 7);
INSERT into animal values(8, 'F', 25, 'SAF20', 'Panthera','leo');

INSERT into animal values(9, 'F', NULL, 'SAF30', 'Diceros','bicornis');
INSERT into animal values(10, 'M', NULL, 'SAF30', 'Diceros','bicornis');
INSERT into breeding_event values(30, '25-Jul-2020', 9, 10);
INSERT into animal values(11, 'F', 30, 'SAF30', 'Diceros','bicornis');

INSERT into breeding_event values(35, '30-Aug-2020', 2, 10);
INSERT into animal values(12, 'M', 35, 'SAF10', 'Diceros','bicornis');

INSERT into breeding_event values(36, '30-Dec-2020', 11, 12);
INSERT into animal values(13, 'M', 36, 'AUS40', 'Diceros','bicornis');

INSERT into animal values(14, 'F', NULL, 'SAF10', 'Lasiorhinus','krefftii');
INSERT into animal values(15, 'M', NULL, 'AUS40', 'Lasiorhinus','krefftii');
INSERT into breeding_event values(40, '30-Jan-2021', 14, 15);
INSERT into animal values(16, 'F', 40, 'AUS20', 'Lasiorhinus','krefftii');

commit;











