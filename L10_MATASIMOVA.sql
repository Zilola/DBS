


--Tasks

DROP TABLE l10Cities;
DROP TABLE L10Towns;
DROP VIEW  CAN_CITY_VU;
DROP VIEW vwCity_DName_VU;
--Question 1

--1.	Create table L10Cities from table LOCATIONS, but only for location numbers less than 2000 
--      (do NOT create this table from scratch, i.e. create and insert in one statement).
    --You will have exactly 10 rows here.
    --When you describe L10Cities, the output is shown below:


--Answer 1


CREATE TABLE L10Cities AS (
SELECT * FROM locations
WHERE location_id < 2000);

DESCRIBE l10Cities;



--Question 2

--2.	Create table L10Towns from table LOCATIONS, but only for location numbers less than 1500 
--(do NOT create this table from scratch). This table will have same structure as table L10Cities. 


-- Answer 2

CREATE TABLE L10Towns AS (
SELECT * FROM locations
WHERE location_id <1500);

DESCRIBE L10Towns;



--Question 3 

--Now you will empty your RECYCLE BIN with one powerful command. Then remove your table L10Towns, 
--so that will remain in the recycle bin. Check that it is really there and what time was removed.
--Hint: Show RecycleBin,   Purge,  Flashback


--Answer 3
SHOW RecycleBin;
PURGE RecycleBin;
DROP TABLE L10Towns;



-- Question 4

--Restore your table L10Towns from recycle bin and describe it. Check what is in your 
--recycle bin now.


-- Answer 4

FLASHBACK TABLE L10Towns TO BEFORE DROP;
SHOW RecycleBin;



-- Question 5

--Now remove table L10Towns so that does NOT remain in the recycle bin. Check that
--is really NOT there and then try to restore it. 
--Explain what happened?


-- Answer 5

DROP TABLE L10Towns;
SHOW RecycleBin;
PURGE TABLE L10Towns;
SHOW RecycleBin;



-- Question 6

--Create simple view called CAN_CITY_VU, based on table L10Cities 
--so that will contain only columns Street_Address, Postal_Code,
--City and State_Province for locations only in CANADA. 
--Then display all data from this view.


-- Answer 6


CREATE VIEW CAN_CITY_VU AS (
SELECT street_address, postal_code, city, state_province FROM  L10Cities
WHERE country_id = 'CA');


SELECT  * from  CAN_CITY_VU;


--Question 7

--Modify your simple view so that will have following aliases instead of 
--original column names: Str_Adr, P_Code, City and Prov and also will 
--include cities from ITALY as well. Then display all data from this view. 


--Answers 7

CREATE OR REPLACE  VIEW CAN_CITY_VU AS (
SELECT street_address AS Str_Adr,
       postal_code AS P_Code ,
       city AS City, 
       state_province AS Prov 
FROM  L10Cities
WHERE country_id in ('CA', 'IT'));

SELECT  * from  CAN_CITY_VU;


--Question 8

--Create complex view called vwCity_DName_VU, based on tables LOCATIONS and DEPARTMENTS, so that will 
--contain only columns Department_Name, City and State_Province for locations in ITALY or CANADA. Include situations even 
--when city does NOT have department established yet. 
--Then display all data from this view.


--Answer 8

CREATE OR REPLACE  VIEW vwCity_DName_VU AS (
SELECT department_name, city, state_province 
FROM departments LEFT JOIN locations 
USING (location_id)
WHERE UPPER(country_id) IN ('IT', 'CA'));

SELECT *FROM vwCity_DName_VU;


-- Question 9

--Modify your complex view so that will have following aliases instead of original column names: DName,
--City and Prov and also will include all cities outside United States



-- Answer 9
 

CREATE OR REPLACE  VIEW vwCity_DName_VU AS (
SELECT department_name DName, city City, state_province Prov
FROM departments full JOIN locations 
USING (location_id)
WHERE UPPER(country_id)  !='US');
--AND UPPER(country_id) IN ('IT', 'CA')

SELECT * FROM vwCity_DName_VU ORDER BY city;



-- Question 10

--Create a transaction, ensuring a new transaction is started, and include all the SQL statements required
--to merge the Marketing and Sales departments into a single department �Marketing and Sales�.
--Create a new department such that the history of employees departments remains intact.  The Sales staff will 
--change locations to the existing Marketing department�s location.  All staff from both previous departments will change
--to the new department.  Add appropriate save points where the transaction could potentially be rolled back to (i.e. good checkpoints).
--Execute these statements, double check everything worked as intended, and then once it works through a single execution,
--commit it.  If errors occur or the data is incorrect, you can rollback and rerun after the errors have been corrected in the SQL code.


-- Answer 10


COMMIT; 
CREATE TABLE "Marketing and Sales"(
SELECT DEPARTMENT_ID E, DEPARTMENT_NAME D, JOB_ID E, DEPARTMENT_ID D
FROM EMPLOYEES E  FULL OUTER JOIN DEPARTMENTS D
ON (DEPARTMENT_ID.E  = DEPARTMENT_ID.D )
WHERE department_name IN ('Sales', 'Marketing'));

 COMMIT;


--SELECT         FROM 
--   WHERE 
--   ORDER BY 


ROLLBACK;

COMMIT;




-- Question 11
--Check in the Data Dictionary what Views (their names and definitions) are created so far in your account.
--Then drop your vwCity_DName_VU and check Data Dictionary again. What is different?


--Answer 11


 -- Difference, it is no longer contained in the data dictionary

