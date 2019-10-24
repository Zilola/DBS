

-- Question 1 �-
-- Display the difference between the Average pay and Lowest pay in the company.  Name this result Real Amount. 
-- Format the output as currency with 2 decimal places.

-- Q1 SOLUTION --

select to_char(round(avg(salary) - min(salary), 2), '$99,999') as "Real Amount"
from employees;

-- Question 2 �-
--Display the department number and Highest, Lowest and Average pay per each department.
--Name these results High, Low and Avg.  Sort the output so that the department with highest average salary is shown first.
--Format the output as currency where appropriate.

-- Q2 SOLUTION --

select department_id as "Dept ID", to_char(max(salary), '$99,999.99') as "High" ,to_char(min(salary),'$99,999.99') as "Low",
to_char(round(avg(salary),2), '$99,999.99') as "Avg"
from employees
where department_id is not null
group by department_id
order by avg(salary) desc;

-- Question 3 �-
-- Display how many people work the same job in the same department. Name these results Dept#, Job and How Many.
-- Include only jobs that involve more than one person.
-- Sort the output so that jobs with the most people involved are shown first.

-- Q3 SOLUTION --

select department_id "Dept#", job_id "Job", count(job_id) "How Many"
from employees
group  by job_id, department_id
having count(job_id) > 1
order by 3 desc;

-- Question 4 --
-- For each job title display the job title and total amount paid each month for this type of the job.
-- Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $11,000.  
-- Sort the output so that top paid jobs are shown first.

-- Q4 SOLUTION --

select job_id "Job",to_char(sum(salary), '$999,999.99') "Amount Paid"
from employees
where job_id not in ('AD_PRES','AD_VP') 
group by job_id
having  sum(salary) >11000
order by 2 desc;

-- Question 5 --
-- For each manager number display how many persons he / she supervises.
-- Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons. 
-- Sort the output so that manager numbers with the most supervised persons are shown first.

-- Q5 SOLUTION --

select manager_id "Manager",count (employee_id) as "Employees"
from employees
where manager_id not in (100,101,102)
group by manager_id 
having count(employee_id) > 2 
order by count(employee_id)desc;


-- Question 6 --
-- For each department show the latest and earliest hire date, BUT
-- exclude departments 10 and 20 
-- exclude those departments where the last person was hired in this decade. (it is okay to hard code dates in this question only)
-- Sort the output so that the most recent, meaning latest hire dates, are shown first.


-- Q6 SOLUTION --

select department_id "Dept#", to_char(max(hire_date), 'yy-mm-dd') "Latest", to_char(min(hire_date), 'yy-mm-dd') "Erliest" 
from employees
where department_id != 10 and department_id != 20   
group by department_id
having max(hire_date) <  to_date('10-01-01', 'yy-mm-dd')
order by 2 desc;


                 
                 

 
