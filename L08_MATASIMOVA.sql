

DROP VIEW vwAllEmps;
DROP VIEW vwAllDepts;
DROP VIEW vwAllDeptSumm;
--Tasks
--Question 1


--   Display the names of the employees whose salary is the same as the lowest salaried employee in any
--   department.

--Answer 1


SELECT first_name ||' '|| last_name as name,  salary
    FROM employees 
    WHERE salary = ANY ( 
                   SELECT MIN(salary) FROM employees);


--Question 2 


--     	Display the names of the employee(s) whose salary is the lowest in each department.
--      where not only the salary but also department_id  in () 

--Answer 2


SELECT first_name ||' '|| last_name as name,  salary, department_id
FROM employees
WHERE (salary, department_id) IN ( 
    SELECT MIN(salary), department_id 
    FROM employees
    GROUP BY department_id);

--Question 3


--      Give each of the employees in question 2 a $120 bonus


--Answer 3


--SELECT first_name ||' '|| last_name as name,  salary+120 salary
--FROM employees 
--WHERE (salary, department_id) IN (
--    SELECT MIN(salary), department_id
--    FROM employees
--    GROUP BY department_id);

UPDATE employees
SET salary = salary + 120
WHERE employee_id = any (
    SELECT employee_id
    FROM employees
    WHERE (salary, department_id) IN  (
            SELECT MIN(salary), department_id
            FROM employees
            GROUP BY department_id
            HAVING department_id is not null));
--Question 4


--	    Create a view named vwAllEmps that consists of all employees includes employee_id, last_name, salary, department_id,
--      department_name, city and country (if applicable)


--Answer 4


CREATE VIEW vwAllEmps AS
    SELECT employee_id, last_name, salary, department_id, department_name, city, country_name
        FROM employees JOIN departments USING (department_id)
        JOIN locations USING (location_id)
        JOIN countries USING (country_id);



--Question 5


--	    Use the vwAllEmps view to:
--a.	    Display the employee_id, last_name, salary and city for all employees
--b.	    Display the total salary of all employees by city
--c.	    Increase the salary of the lowest paid employee(s) in each department by 120
--d.	    What happens if you try to insert an employee by providing values for all columns in this view?
--e.	    Delete the employee named Vargas. Did it work? Show proof.


--Answer 5

--a.    Display the employee_id, last_name, salary and city for all employees

SELECT employee_id, last_name, salary, city 
FROM vwAllEmps;

--b.    Display the total salary of all employees by city 

SELECT city, SUM(salary) salary
FROM vwAllEmps
GROUP BY city
ORDER BY 2;

--c.    Increase the salary of the lowest paid employee(s) in each department by 120

UPDATE vwAllEmps
SET salary = salary+ 120
WHERE (salary,department_id) IN (
    SELECT MIN(salary), department_id
    FROM vwAllEmps
    GROUP BY department_id );



--d.    What happens if you try to insert an employee by providing values for all columns in this view?

INSERT INTO vwAllEmps
VALUES('Tashkent', 'Uzkekistan', 11, 'IT',100,'Inomalieva', 3500);

-- Cannot insert the values to views we can only read but not insert. Insert we can only directly to the tables
-- Tried
-- OUTPUT: SQL Error: ORA-01776: cannot modify more than one base table through a join view
--01776. 00000 -  "cannot modify more than one base table through a join view"
--*Cause:    Columns belonging to more than one underlying table were either
--           inserted into or updated.


--e.    Delete the employee named Vargas. Did it work? Show proof.

DELETE FROM vwallemps
WHERE last_name = 'Vargas';
-- Surpisingly DELETED
-- OUTPUT: 1 row deleted.




--Question 6

--	    Create a view named vwAllDepts that consists of all departments and includes department_id, department_name,
--      city and country (if applicable)

--Answer 6


CREATE VIEW vwAllDepts AS
SELECT department_id, department_name, city, country_name
FROM departments JOIN locations USING (location_id)
                 JOIN countries USING (country_id);




--Question 7

--	    Use the vwAllDepts view to:
--a.	For all departments display the department_id, name and city
--b.	For each city that has departments located in it display the number of departments by city


--Answer 7
--a     For all departments display the department_id, name and city

SELECT  department_id, department_name,city
FROM vwAllDepts;

--b     For each city that has departments located in it display the number of departments by city     
SELECT city, COUNT(department_id) departments
FROM vwAllDepts
GROUP BY  CITY;

--Question 8

--	Create a view called vwAllDeptSumm that consists of all departments and includes for each department: department_id,
--department_name, number of employees, number of salaried employees, total salary of all employees. Number of Salaried must be
--different from number of employees. The difference is some get commission.

--Answer 8

CREATE VIEW vwAllDeptSumm AS
SELECT department_id, department_name, COUNT(employee_id) employees,
COUNT(employee_id)- COUNT(commission_pct) "Salaried Employees", SUM(salary) "Total Salary"
FROM employees JOIN departments USING(department_id)
GROUP BY department_id, department_name;

-- Question 9
-- Use the vwAllDeptSumm view to display department name and number of employees for departments
-- that have more than the average number of employees 

-- Answer 9
-- view havent created yet
SELECT department_name, employees
FROM vwAllDeptSumm
WHERE employees >=(SELECT AVG(employees)
                    FROM vwAllDeptSumm);



-- Question 10

--	A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees table and to 
       --allow them to retrieve, insert and update data in your departments table. Show proof
--  B) Use the REVOKE statement to remove permission for that student to insert and update data in your departments table


--Answer 10

--      A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees table and to 
       --allow them to retrieve, insert and update data in your departments table. Show proof 
       --how I can check neptute account
GRANT
    SELECT
ON
    employees
TO
    Neptune;
GRANT
    SELECT,
    INSERT,
    UPDATE
ON
    departments
TO 
    Neptune;

--      B) Use the REVOKE statement to remove permission for that student to insert and update data in your departments table

REVOKE
    INSERT,
    UPDATE
ON
    departments
FROM
    Neptune;





 