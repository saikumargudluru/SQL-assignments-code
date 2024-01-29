create database db;
use db;
create table company(e_id int,e_full_name varchar(20),e_first_name varchar(15),e_last_name varchar(15),jobtitle varchar(50),department varchar(30),salary int);
insert into company 
values(1,'hari challa','hari','challa','sales_resprentative','sales',70000)
,(2,'saikumar gudluru','saikumar','gudluru','accountant','finance',59000)
,(3,'priya dola','priya','dola','sale exceutive','sales',40000)
,(4,'vinay namburu','vinay','namburu','accountant','business development',78000)
,(5,'ravi pacha','ravi','pacha','sales_associate','sales',35000)
,(6,'krishna gudluru','krishna','gudluru','sale_coordinator','sales',50000)
,(7,'vamsi ragineni','vamsi','ragineni','marketing_coordinator','marketing',48000)
,(8,'vishnu gudluru','vishnu','gudluru','finance_analyst','finance',45000)
,(9,'ganesh ragi','ganesh','ragi','marketing_analyst','marketing',55000)
,(10,'yugadhar chava','yugadhar','chava','account_manager','sales',75000);
create table m_details(m_id int,m_full_name varchar(20),m_first_name varchar(10),m_last_name varchar(10));
insert into m_details values(1,'raju adama','raju','adama'),(2,'mouri adarsh','mouri','adarsh'),(3,'priya agrawal','priya','agrawal'),(4,'nani arora','nani','arora'),(5,'ashok misar','ashok','misar'),(6,'vignesh dev','vignesh','dev'),(7,'akhila priya','akhil','priya'),(8,'asrao','as','rao'),(9,'dinesh kathi','dinesh','kathi'),(10,'ramu mukesh','ramu','mukesh');

--1.write a query to find the top 10 % of employees with the highest salaries in the company.include their full name and salary,sort the results in descending order by salary.
select top 10 percent   e_full_name,salary from company
order by salary desc;

--2.write a query to calculate the average salary for each department in the company.include the department name,the number of employees in each department and the average salary.only show department with atleast 5 employees.
select department,count(*) as 'number of employees',avg(salary) as average_salary from company
group by department
having count(*) >=5;

--3.write a query to find the 3 most common last names among all employees in the company include the last name and the number of employees with at least 5 employees.
select e_last_name ,count(*) as 'number of employees with last name' from company
group by e_last_name
having count(*) =3;

--4.write a query to find the highest and lowest salaries for each job title in the company include the job title,the highest salary,and the lowest salary.only show job titles  with employees at least 2 employees.
select jobtitle,max(salary) as highest_salary,min(salary) as lowest_salary from company
group by jobtitle
having count(*) >=2;

--5.write a query to find all employees who have the same first name as their manager include the employee's full name,their manager's full name and their job title.
select E.e_full_name as employee_full_name ,M.m_full_name as manager_full_name ,E.jobtitle  from company as E
join
m_details as M 
on
E.e_first_name=M.m_first_name ;


select * from company;

alter view v_company
with schemabinding,encryption
as 
select e_id,e_first_name from dbo.company;

select * from v_company;

drop table company;

































