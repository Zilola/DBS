

-- Question 1
--	Start by entering in the SQL Developer worksheet:
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;
-- Q1 Solution
--  The widest and longest is EMPLOYEES




-- Question 2
--    If the following SELECT statement does NOT execute successfully, how would you fix it?    

SELECT last_name �LName�, job_id �Job Title�, 
       Hire Date �Job Start�
       FROM employees;
-- Q2 Solution 
--  because the name of column is Hire_Date not Hire Date. The correct answer:
SELECT last_name "LName", job_id "Job Title",
    Hire_Date "Job Start" 
    FROM employees; 




-- Question 3 
--    There are THREE coding errors in this statement. Can you identify them? 
SELECT employee_id, last name, commission_pct Emp Comm,
FROM employees;
-- Q3 Solution 
-- 1. column 'last name' does not exist, after word 'last' query analizer acpecting keyword FROM.
-- 2. quotes missing in "Emp Comm".
-- 3. extra comma after word 'Emp Comm
--The correct answer is below:
SELECT  employee_id, last_name, commission_pct "Emp Comm"
FROM employees; 




-- Question 4
-- What command would show the structure of the LOCATIONS table?
-- Q4 Solution

SELECT * FROM LOCATIONS;
SELECT LOCATION_ID "City#", CITY "City", STATE_PROVINCE ||' IN THE '|| COUNTRY_ID   "Province with Country Code"
FROM LOCATIONS
desc locations;

