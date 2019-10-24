

-- Question 1
-- Display the employee_id, last name and salary of employees earning in the range 
-- of $8,000 to $10000 inclusive. 
-- Sort the output by top salaries first and then by last name.

-- Solution 1: 

--OPTION I
SELECT  EMPLOYEE_ID, LAST_NAME "Last name",  SALARY "Salary", COMMISSION_PCT "Commission Percent"
FROM EMPLOYEES
WHERE SALARY BETWEEN 8000 AND 10000
AND commission_pct is not null
 ORDER BY 3 DESC, 2;
 
--OPTION II
SELECT EMPLOYEE_ID, LAST_NAME "Last name", SALARY "Salary", COMMISSION_PCT "Commission Percent"
FROM EMPLOYEES
WHERE SALARY >=8000 AND SALARY <=10000
AND commission_pct is not null
ORDER BY SALARY DESC, LAST_NAME;



-- Question 2
-- Modify previous query (#1) so that additional condition is to display only if they work as
-- Programmers or Sales Representatives. Use same sorting as before.
-- Solution 2

-- Option I

SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE (JOB_ID LIKE '%PROG%' 
OR  JOB_ID LIKE  '%SA_REP%')
AND (SALARY >=8000 AND SALARY <=10000)
ORDER BY SALARY DESC, LAST_NAME;

-- Option II

SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE (JOB_ID = 'SA_REP' OR JOB_ID = 'IT_PROG')
AND (SALARY >=8000 AND SALARY <=10000)
ORDER BY SALARY DESC, LAST_NAME;




-- Question 3
-- The Human Resources department wants to find high salary and low salary employees.
-- Modify previous query (#2) so that it displays the same job titles but for people who
-- earn outside the range of $8,000 to $11000 exclusive. Use same sorting as before.

-- Solution 3

-- Option I
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE (JOB_ID = 'SA_REP' OR JOB_ID = 'IT_PROG')
AND NOT (SALARY >= 8000 AND SALARY <= 11000)
ORDER BY SALARY DESC, LAST_NAME;

-- Option II
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE (JOB_ID = 'SA_REP' OR JOB_ID = 'IT_PROG')
AND  (SALARY < 8000 OR SALARY > 11000)
ORDER BY SALARY DESC, LAST_NAME;


-- Question 4
-- The company needs a list of long term employees, in order to give them a thank you
-- dinner. Display the last name, job_id and salary of employees hired after 2016. List the
-- most recently hired employees first.

-- Solution 4
SELECT LAST_NAME AS "Last Name", SALARY as "Salary", JOB_ID as "Job Title", To_char(hire_date, 'YY-MM-DD') as "Started"
FROM EMPLOYEES
where 	hire_date > TO_DATE ('01-JANUARY-2016', 'DD-MONTH-YYYY')
ORDER BY HIRE_DATE DESC;

--QUESTION 5
--Modify previous query (#4) so that it displays only employees earning more than $12,000 and
--hired before 2017. List the output by job title alphabetically and then by highest paid employees.

-- Solution 5
select LAST_NAME "Last Name", TO_CHAR(salary, '$99,999.99')"Salary", JOB_ID "Job Title", TO_CHAR(hire_date, 'YY-MM-DD') as "Started"
FROM EMPLOYEES
WHERE SALARY > 12000 AND HIRE_DATE <TO_DATE('91-01-01', 'YY-MM-DD')
ORDER BY JOB_ID, SALARY DESC;

--QUESTION 6
--Display the job titles and full names of employees whose first name contains an �c� or �C� anywhere.

--Solution 6 
SELECT job_id "Job Title" , FIRST_NAME ||' '|| LAST_NAME AS "Full Name"
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%C%' OR
 FIRST_NAME LIKE '%c%';
 
 
-- Question 7
--	Create a report to display last name, salary, and commission percent for all employees that earn a commission and a salary less than 9000.

-- Solution 7 
SELECT LAST_NAME "Last name",  salary "Salary", COMMISSION_PCT "Commission Percent"
FROM EMPLOYEES
WHERE SALARY <9000
AND commission_pct is not null;


-- Question 8
--Do the same as question 7, but put the report in order of descending salaries.

-- Solution 8
SELECT LAST_NAME "Last name",  salary "Salary", COMMISSION_PCT "Commission Percent"
FROM EMPLOYEES
WHERE SALARY <9000
AND commission_pct is not null
 ORDER BY salary desc;


-- Question 9
--Do the same as 8, but use a numeric value instead of a column name to do the sorting.

-- Solution 9
SELECT LAST_NAME "Last Name",  salary "Salary", COMMISSION_PCT "Commission Percent"
FROM EMPLOYEES
WHERE SALARY <9000
AND commission_pct is not null
 ORDER BY 2 DESC;
 
 






