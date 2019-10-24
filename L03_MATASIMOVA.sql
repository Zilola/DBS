

-- Question 1
--Write a query to display the tomorrow�s date in the following format:
--January 10th of year 2019
--the result will depend on the day when you RUN/EXECUTE this query.  Label the column �Tomorrow�.


-- Solution 1: 

select to_char(sysdate +1, 'Month ddth') ||' of year '|| to_char(sysdate +1,'yyyy') as "tomorrow" FROM dual;




-- Question 2
--For each employee in departments 20, 50 and 60 display last name, first name, salary, and salary
--increased by 4% and expressed as a whole number.  Label the column �Good Salary�.  
--Also add a column that subtracts the old salary from the new salary and multiplies by 12.
--Label the column "Annual Pay Increase".

-- Solution 2: 
select last_name as "Last Name",first_name "First Name", to_char(salary, '$99,999') as "Salary", 
to_char(round(salary +(salary * 0.04)),'$99,999') as "Good Salary",to_char((((salary +(salary * 0.04))-(salary))*12), '$99,999')  as "Annnul Pay Increase"
from employees
where department_id in (20, 50, 60)




-- Question 3
--Write a query that displays the employee�s Full Name and Job Title in the following format:
--DAVIES, CURTIS is ST_CLERK 
--Only employees whose last name ends with S and first name starts with C or K.
--Give this column an appropriate label like Person and Job.  Sort the result by the employees� last names.


-- Solution 3
select (UPPER(last_name) ||', ' || UPPER(first_name) || ' is ' || INITCAP(case job_id
    when 'ST_CLERK' then 'Store Clerk'
    when 'SA_REP' then 'Sales Rep'
    when 'ST_MAN' then 'Store Manager' end)) as "Employee Jobs"

from employees
where
    last_name like '%s'
    and (first_name like 'C%' or first_name like 'K%')
order by last_name;



-- Question 4
--For each employee hired before 1997, display the employee�s last name, hire date and
--calculate the number of YEARS between TODAY and the date the employee was hired.
  --Label the column Years worked.
  --Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.
  
-- Solution 4

Select last_name as "Last Name", to_char(hire_date, 'YY-MM-DD') "Hire Date" , round(MONTHS_BETWEEN(sysdate, hire_date) /12) as "Years worked"  
from employees
where (extract (year from hire_date) < 1997)
order by 3
 

-- Question 5
--Create a query that displays the city names, country codes and state province names, but only for
--those cities that starts with S and has at least 8 characters in their name. If city does not have a province name assigned,
--then put Unknown Province.  Be cautious of case sensitivity!

-- Solution 5 

SELECT CITY "City",COUNTRY_ID "Country",NVL(STATE_PROVINCE, 'Unknown Province')"Province"
FROM LOCATIONS
WHERE (LENGTH(CITY)>=8 AND CITY LIKE '%S%');


-- Question 6
--Display each employee�s last name, hire date, and salary review date, which is the first Thursday after
--a year of service, but only for those hired after 2017.  

-- Solution 6
-- THURSDAY, August the Thirty-First of year 2018
SELECT  last_name as "Last Name", to_char(hire_date, 'YY-MM-DD') as "Hire Date",
to_char((next_day(add_months(hire_date, 12),'Thursday')), 'FMDAY, Month"    the "ddspth "of year" yyyy') "Review Date"
FROM EMPLOYEES
where hire_date > '01-JAN-17'
order by 2;

SELECT  last_name as "Last Name", to_char(hire_date, 'YY-MM-DD') as "Hire Date",
to_char((next_day(add_months(hire_date, 12),'Thursday')), 'FMDAY, Month"    the "ddspth "of year" yyyy') "Review Date"
FROM EMPLOYEES
where hire_date > '01-JAN-17'
order by 2;

SELECT last_name as"Last Name", hire_date as "Hire Date", to_char((next_day(add_months(hire_date, 12),'THURSDAY')), 'fmday , month" the "ddspth "of year " yyyy') "Review Date" FROM EMPLOYEES where hire_date > '2017-01-01' order by "Hire Date" ;


SELECT last_name as"Last Name", hire_date as "Hire Date", 
to_char((next_day(add_months(hire_date, 12),'THURSDAY')), 'fmday , 
month" the "ddspth "of year " yyyy') "Review Date"
FROM EMPLOYEES where hire_date > '2017-01-01' order by "Hire Date" ; 

SELECT  last_name as "Last Name", to_char(hire_date, 'YY-MM-DD') as "Hire Date",
to_char((next_day(add_months(hire_date, 12),'Thursday')), 'FMDAY, Month" the "ddspth "of year" yyyy') "Review Date"
FROM EMPLOYEES
where hire_date > '01-JAN-17'
order by 2;

SELECT  last_name as "Last Name", to_char(hire_date, 'YY-MM-DD') as "Hire Date",
to_char((next_day(add_months(hire_date, 12),'Thursday')), 'FMDAY, Month" the "ddspth "of year" yyyy') "Review Date"
FROM EMPLOYEES
where hire_date > '01-JAN-17'
order by 2;




