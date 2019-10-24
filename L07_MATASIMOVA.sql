

--  TASKS

--  Question 1
--  The HR department needs a list of IDs of departments that do not contain
--  the job ID of ST_CLERK> Use a set operator to create this report. 

-- Answer 1

SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees
WHERE UPPER(job_id) = 'ST_CLERK';

-- Question 2
-- Same department requests a list of countries that have no departments located in them.
-- Display country ID and the country name. Use SET operators.  
-- spisok  stran gde netu departmenta

-- Answer 2

SELECT country_id, country_name
FROM countries
MINUS
SELECT country_id, country_name
FROM countries
JOIN locations USING(country_id)
JOIN departments USING(location_id);

 




-- Queestion 3
--	The Vice President needs very quickly a list of departments 10, 50, 20 in that order. job and department ID are to be displayed.


-- Answers 3
SELECT 
DISTINCT job_id, department_id
FROM employees
WHERE department_id= 10
UNION ALL
SELECT DISTINCT job_id, 
department_id
FROM employees
WHERE department_id= 50
UNION ALL
SELECT 
DISTINCT job_id, department_id
FROM employees
WHERE department_id= 20;


-- Question 4

--Create a statement that lists the employeeIDs and JobIDs of those employees who currently have a job title that is
--the same as their job title when they were initially hired by the company (that is, they changed jobs but have now gone back
--to doing their original job).

-- Answer 4
SELECT employee_id, job_id 
FROM employees 
 
  INTERSECT 
 
 
 SELECT employee_id, job_id 
 FROM job_history 
 ORDER BY 1; 
 

-- Question 5

--	The HR department needs a SINGLE report with the following specifications:
        --a.	Last name and department ID of all employees regardless of whether they belong to a department or not.
        --b.	Department ID and department name of all departments regardless of whether they have employees in them or not.

        --Write a compound query to accomplish this.

--Answer 5


SELECT LAST_NAME, DEPARTMENT_ID, TO_CHAR(NULL) AS DEPARTMENT_ID
FROM EMPLOYEES
UNION
SELECT TO_CHAR(NULL), DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;


