
 
--Question 1
--	Create table L09SalesRep 
-- load it with data from table EMPLOYEES table, 
--only for people in department 80.


CREATE TABLE L09SalesRep(
PepId   NUMBER (6),
FName   VARCHAR2(20),
LName   VARCHAR2(25),
Phone#  VARCHAR2(20),
Salary  NUMBER(8,2),
Commision NUMBER(2,2)
);


INSERT INTO L09SalesRep
    SELECT  employee_id, first_name, last_name, phone_number, salary, commission_pct 
       FROM employees
    WHERE department_id = 80;
    
 --Question 2
 --Create L09Cust table.
 CREATE TABLE L09Cust (
   CUST#	  	NUMBER(6),
   CUSTNAME 	VARCHAR2(30),
   CITY 		VARCHAR2(20),
   RATING		CHAR(1),
   COMMENTS	VARCHAR2(200),
   SALESREP#	NUMBER(7) );
   
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(501, 'ABCLTD.', 'Montreal', 'C', 201);
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(502, 'BlackGiant','Ottawa','B',202);
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(503, 'Mother Goose', 'London', 'B', 202); 
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(701, 'BLUE SKY LTD', 'Vancouver', 'B', 102); 
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(702, 'MIKE and SAM LTD', 'Kingston', 'A', 107); 
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(703, 'RED PLANET', 'Missisauga', 'C', 107); 
 INSERT INTO L09Cust (cust#, custname, city, rating, salesrep#) VALUES(717, 'BLUE SKY LTD', 'Regina', 'D', 102); 
 
 --Question 3
 --	Create table L09GoodCust by using following columns but only if their rating is A or B. 
  CREATE TABLE L09GoodCust(
  CustId       NUMBER (6),
  "Name"	   VARCHAR2(30),
  "Location"   VARCHAR2(20),
  RepId		   NUMBER(7)
  );
 
 INSERT INTO  L09GoodCust
     SELECT cust#, custname, city,salesrep#
        FROM L09Cust
     WHERE rating IN ('A','B');
    
--Qustion 4
-- add new column to table L09SalesRep called JobCode that will be of variable character type with max length of 12

ALTER TABLE L09SalesRep
    ADD JobCode VARCHAR2(12);
    
DESCRIBE L09SalesRep;

--Question 5
--	Declare column Salary in table L09SalesRep as mandatory one and Column Location in table L09GoodCust as optional one.

ALTER TABLE L09SalesRep 
     MODIFY (salary NUMBER(8, 2) NOT NULL, 
             fname VARCHAR2(37)); 
 
DESCRIBE  L09GoodCust;
-- Question 6
--Remove JobCode column from SALESREP so it doesn't affect daily performance
ALTER TABLE L09SalesRep
DROP COLUMN JobCode;

-- Question 7
--Make PK for RepID and CustID

ALTER TABLE L09SalesRep
    ADD CONSTRAINT L09SalesRep_RepID_pk PRIMARY KEY(PEPID);
    
ALTER TABLE L09Cust
   ADD CONSTRAINT L09Cust_CustID_pk PRIMARY KEY (cust#);
   
 DESCRIBE L09Cust  
--Question 8
--
ALTER TABLE L09SalesRep
    ADD CONSTRAINT L09SalesRep_PHONE#_uk UNIQUE (PHONE#);
    
ALTER TABLE L09Cust    
   ADD CONSTRAINT L09Cust_CUSTNAME_uk UNIQUE(CUSTNAME);
   
 describe L09SalesRep 
 
-- Question 9
--Restrict Salary to 6000 - 12000 and 

ALTER TABLE L09SalesRep 
     ADD CONSTRAINT L09SalesRep_salary_ck CHECK(salary >= 6000 AND salary <= 12000) 
     ADD CONSTRAINT L09SalesRep_commission_ck CHECK(COMMISION <= .50); 

-- Question 12
--  Disable the FK and enter the old values for RepID.  
--      Enable the FK. What happened? 
-- The FK was enabled 
 
 
-- Question 13
--      Get rid of the FK then modify the CK from Q9 
--      and allow Salary to range from 5000 to 15000 
ALTER TABLE L09SalesRep 
     DROP CONSTRAINT L09SalesRep_salary_ck; 

 
ALTER TABLE L09SalesRep 
     ADD CONSTRAINT L09SalesRep_salary_ck CHECK(salary >= 5000 AND salary <= 15000); 
 
 
 -- Question 14
 --Describe L09SalesRep and L09GoodCust 
SELECT constraint_name, constraint_type, 
       search_condition, table_name
    FROM user_constraints
    WHERE lower(table_name) IN ('l09salesrep','l09goodcust')
    ORDER BY table_name, constraint_type;
