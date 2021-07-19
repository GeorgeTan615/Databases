--****PLEASE ENTER YOUR DETAILS BELOW****
--mh-queries.sql

--Student ID: 30884128
--Student Name: George Tan Juan Sheng
--Tutorial No: 5

/* Comments for your marker:




*/


/*
    Q1
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ht_nbr, emp_nbr, emp_lname, emp_fname, to_char(end_last_annual_review,'Dy DD Mon yyyy') AS REVIEW_DATE
FROM mh.endorsement JOIN mh.employee USING (emp_nbr)
WHERE end_last_annual_review > to_date('31-Mar-2020','dd-mon-yyyy')
GROUP BY ht_nbr, emp_nbr, emp_lname, emp_fname, end_last_annual_review
ORDER BY end_last_annual_review;
	
/*
    Q2
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT charter_nbr, client_nbr, client_lname, client_fname, charter_special_reqs
FROM mh.charter JOIN mh.client USING (client_nbr)
WHERE charter_special_reqs IS NOT NULL
GROUP BY charter_nbr, client_nbr, client_lname, client_fname, charter_special_reqs
ORDER BY charter_nbr;


/*
    Q3
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT 
	DISTINCT charter_nbr, 
	CASE 
	WHEN client_fname IS NOT NULL AND client_lname IS NOT NULL then client_fname || ' ' ||client_lname 
	WHEN client_fname IS NULL OR client_lname IS NULL then client_fname || client_lname 
	END as FULLNAME,
	charter_cost_per_hour
FROM 
    ((mh.charter_leg cl JOIN mh.location l on cl.location_nbr_destination = l.location_nbr) 
    JOIN mh.charter USING (charter_nbr)) 
    JOIN mh.client USING (client_nbr)
WHERE 
    cl.location_nbr_destination = (SELECT location_nbr FROM mh.location WHERE location_name = 'Mount Doom') 
    AND (charter_cost_per_hour < 1000 OR charter_special_reqs IS NULL)
GROUP BY charter_nbr, client_fname, client_lname, charter_cost_per_hour
ORDER BY FULLNAME DESC;


/*
    Q4
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ht_nbr, ht_name, COUNT(ht_nbr) AS NO_OF_HELICOPTERS_OWNED
FROM mh.helicopter JOIN mh.helicopter_type USING (ht_nbr)
GROUP BY ht_nbr, ht_name
HAVING COUNT(ht_nbr) >= 2
ORDER BY NO_OF_HELICOPTERS_OWNED DESC;


/*
    Q5
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT l.location_nbr, l.location_name, COUNT(cl.location_nbr_origin) AS NO_TIMES_USED_AS_ORIGIN
FROM mh.charter_leg cl JOIN mh.location l on cl.location_nbr_origin = l.location_nbr
GROUP BY l.location_nbr, l.location_name
HAVING COUNT(cl.location_nbr_origin) >= 1
ORDER BY NO_TIMES_USED_AS_ORIGIN;



/*
    Q6
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ht_nbr, ht_name, NVL(SUM(heli_hrs_flown),0)AS TOTAL_HOURS_FLOWN
FROM mh.helicopter RIGHT OUTER JOIN mh.helicopter_type USING (ht_nbr)
GROUP BY ht_nbr, ht_name
ORDER BY TOTAL_HOURS_FLOWN;


/*
    Q7
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT charter_nbr, to_char(cl_atd, 'DD-MON-YYYY HH24:MI:SS') AS DEPART_DT
FROM (mh.charter FULL OUTER JOIN mh.employee USING (emp_nbr)) FULL OUTER JOIN mh.charter_leg USING (charter_nbr)
WHERE emp_fname = 'Frodo' and emp_lname = 'Baggins' and cl_leg_nbr = 1 and 
    charter_nbr NOT IN 
    (SELECT DISTINCT charter_nbr
    FROM (mh.charter FULL OUTER JOIN mh.employee USING (emp_nbr)) FULL OUTER JOIN mh.charter_leg USING (charter_nbr)
    WHERE cl_atd IS NULL and charter_nbr IS NOT NULL)
GROUP BY charter_nbr,cl_atd
ORDER BY cl_atd DESC;




/*
    Q8
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT charter_nbr, client_nbr, NVL(client_lname, '-'), NVL(client_fname,'-'), lpad(to_char(SUM((cl_ata-cl_atd)*24*charter_cost_per_hour),'$999990.99'),20,' ') AS TOTALCHARTERCOST
FROM mh.charter JOIN mh.client USING (client_nbr) JOIN mh.charter_leg USING (charter_nbr)
WHERE 
    charter_nbr NOT IN 
    (SELECT DISTINCT charter_nbr
    FROM mh.charter  JOIN mh.employee USING (emp_nbr)  JOIN mh.charter_leg USING (charter_nbr)
    WHERE cl_atd IS NULL and charter_nbr IS NOT NULL)
GROUP BY charter_nbr, client_nbr, NVL(client_lname, '-'), NVL(client_fname,'-')
HAVING SUM((cl_ata-cl_atd)*24*charter_cost_per_hour) < (SELECT AVG(TOTALCHARTERCOST) FROM(
                        SELECT charter_nbr, SUM((cl_ata-cl_atd)*24*charter_cost_per_hour) AS TOTALCHARTERCOST
                        FROM mh.charter JOIN mh.charter_leg USING (charter_nbr)
                        WHERE 
                            charter_nbr NOT IN 
                            (SELECT DISTINCT charter_nbr
                            FROM mh.charter JOIN mh.employee USING (emp_nbr) JOIN mh.charter_leg USING (charter_nbr)
                            WHERE cl_atd IS NULL and charter_nbr IS NOT NULL)
                        GROUP BY charter_nbr))
ORDER BY TOTALCHARTERCOST DESC;



/*
    Q9
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT DISTINCT charter_nbr, emp_fname || ' '||emp_lname AS PILOTNAME, 
    CASE
    WHEN client_fname IS NULL OR client_lname IS NULL THEN client_fname || ''||client_lname
    WHEN client_fname IS NOT NULL AND client_lname IS NOT NULL THEN client_fname || ''||client_lname
    END AS CLIENTNAME
FROM mh.charter JOIN mh.employee USING (emp_nbr) JOIN mh.client USING (client_nbr) JOIN mh.charter_leg USING (charter_nbr)
WHERE 
	charter_nbr NOT IN 
	(SELECT DISTINCT CHARTER_NBR
	FROM mh.charter JOIN mh.employee USING (emp_nbr) JOIN mh.charter_leg USING (charter_nbr)
	WHERE (to_char(cl_atd, 'DD-MON-YYYY HH24:MI:SS') != to_char(cl_etd, 'DD-MON-YYYY HH24:MI:SS') AND cl_atd IS NOT NULL AND cl_etd IS NOT NULL) OR cl_ata IS NULL)
GROUP BY charter_nbr, emp_fname, emp_lname, client_fname,client_lname
ORDER BY charter_nbr;






