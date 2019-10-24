

-- Question 1

--   	Display the department name, city, street address
--      and postal code for departments sorted by city and department name.

-- Solution 1: 
      
select department_name as DEPARTMENT, city as CITY, street_address as ADDRESS, postal_code as "Postal Code"
from locations l , departments d
where d.location_id = l.location_id
order by city, d.department_name;


-- Question 2

--      Display full name of employees as a single field using format of �Last, First�, 
--      their hire date, salary, department name and city, but only for departments with names starting
--      with an A or I sorted by department name and employee name. 


-- Solution 2:
select last_name ||', '|| first_name as "EMPLOYEE", to_char(hire_date, 'yy-mm-dd')  as HIRED , salary as SALARY, department_name as DEPARTMENT, city AS CITY
from employees e, departments d, locations l
where l.location_id = d.location_id and d.department_id = e.department_id
and (department_name  like 'A%'  or department_name like 'I%')
order by 4 ,1 ;

-- Question 3

--      Display the full name of the manager of each department in states/provinces of Ontario,
--      New Jersey and Washington along with the department name, city, postal code and province name.
--      Sort the output by city and then by department name.

-- Solution 3:

select  distinct e.first_name ||' ' || e.last_name as "Manager", d.department_name as "Department", city as "City", postal_code as PC, state_province as "State/Prov"
from departments d, employees e, locations l
where d.manager_id = e.employee_id and l.location_id = d.location_id and l.state_province in ('Ontario','Washington','New Jersey')
order by city, department_name;


-- Question 4
--  	Display employee�s last name and employee number along with their manager�s last name and manager number for employees 
--      in department 20,50, and 60. Label the columns Employee, Emp#, Manager, and Mgr# respectively.


-- Solution 4:
   
   select   emp.last_name as "Employee", emp.employee_id as "Emp#", mng.last_name "Manager", mng.manager_id as "Mgr#"
   from employees emp, employees mng
   where emp.manager_id = mng.employee_id
   and mng.manager_id is not null
   and emp.department_id in (20,50,60) ;
   



-- Question 5:

-- 	    Display the department name, city, street address, postal code and country name for all Departments. Use the 
--      JOIN and USING form of syntax.  Sort the output by department name descending.



--      Solution 5
   
select d.department_name, l.city, l.street_address, l.postal_code, c.country_name
from  departments d
join locations l
    using (location_id)
join countries c
    using (country_id)
order by d.department_name desc;
 


-- Qustion 6:

--          Display full name of the employees, their hire date and salary together with their department name,
--          but only for departments which names start with A or I.
--            a.	Full name should be formatted:  First / Last. 
--            b.	Use the JOIN and ON form of syntax.
--            c.	Sort the output by department name and then by last name.




--      Solution 6:


 select e.first_name ||' / '|| e.last_name as "EMPLOYEE" , to_char(e.hire_date, 'yy-mm-dd') as "HIRE_DATE", to_char(e.salary, '$999,999.00') as "SALARY", d.department_name as "dept."
 from employees e
    join departments d
        on e.department_id = d.department_id
where d.department_name like 'A%' or d.department_name like 'I%' 
    order by d.department_name ,e.last_name;
       


-- Question 7:


--        Display full name of the manager of each department in provinces Ontario, New Jersey and Washington plus department name,
--        city, postal code and province name. 
--	           a.     Full name should be formatted: Last, First.  
--	           b.     Use the JOIN and ON form of syntax.
--	           c.     Sort the output by city and then by department name. 


 
--      Solution 7: 

select e.first_name ||' / ' ||  e.last_name as "Manager", d.department_name as "Dept",l.city as "City", l.postal_code "PC", l.state_province as "State/Prvo" 
from employees e
        join departments d
            on e.department_id = d.department_id
        join locations l
            on l.location_id = d.location_id
                where l.state_province in ('Ontario', 'New Jersey', 'Washington')
                    order by l.city, d.department_name;
 
 
-- Question 8:


--      	Display the department name and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.
--              a.	Use JOIN and ON form of the syntax.
--              b.	Sort the output so that department with highest average salary are shown first.



--      Solution 8:
 select d.department_name as "DEPT", to_char(max(e.salary), '$999,999.00') as "High", to_char(min(e.salary), '$999,999.00') as "Low", to_char(avg(e.salary), '$999,999.00') "Avg" 
 from departments d
    join employees e
        on d.department_id = e.department_id
            group by d.department_name
                order by 4 desc;
    
        
-- Question 9:


--      	Display the employee last name and employee number along with their manager�s last name and manager number. Label the columns Employee, 
--              a.	Emp#, Manager, and Mgr#, respectively. 
--              b.	Include also employees who do NOT have a manager and also employees who do NOT supervise anyone (or you could say managers without employees to supervise).


--      Solution 9:


  select emp.last_name as "Employee", emp.employee_id as "Emp#", mng.last_name "Manager", mng.employee_id as "Mgr#"
   from employees emp 
        full outer join employees mng      
            on emp.manager_id = mng.employee_id;
            

 
            
     

   
   
   

   

