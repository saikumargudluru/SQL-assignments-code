--CAPSTONE-2
/*Q1: What is user defined stored procedure and user defined function, explain and write the 
differences?*/
--user defined stored procedure
--user defined stored procedure is created by user to saved written script and use the 
--same script so many time whenever it is neccessary and in user defined storted procedure 
--returns a value is optional.
--user defined function
--user defined function is created by user to saved written script and use the same 
--script so many time whenever it is neccessary but user defined function must return 
--single value. 
--difference between user defined storted procedure and user defined function
--user defined storted procedure user defined function
--1.return value is optional. 1.must return a single value.
--2.can return one or more values. 2. can return only one value.
--3.can have both input and output parameter. 3.can never have a output parameter.
--4.it is not must to use begin and end. 4.begin and end must.
--5.last statement could be anything. 5.last statement should be return.
--6.storted procedure can call a function. 6.function cannot call a storted 
--procedure.
--7.cannot call in select statement. 7.can call in select statement.
--8.it supports error handing. 8.it doesnot supports error handing.
/*Q2: what are advantage of using stored procedure?*/
--advantage of storted procedure
--1.code reusability. 
--2.error handing.
--3.better perfomance than user defined function.
--4.provide better security.
--5.data profiling.
--6.data verification or data validation is easy.
/*Q3: what is your understanding with complex stored procedure explain with example.*/
--complex stored procedure is a stored procedure that performs a complex task,such as 
--joining multiple tables,performing calcualtaions, or updating data in the table
create procedure information
@businessentityid int
as
begin
select
p.BusinessEntityID,p.Title,p.FirstName,p.MiddleName,p.LastName,em.EmailAddress,pho.PhoneN
umber
from Person.Person p
inner join
HumanResources.Employee e
on
p.BusinessEntityID=e.BusinessEntityID
inner join
Person.EmailAddress em
on
e.BusinessEntityID=em.BusinessEntityID
inner join
person.PersonPhone pho
on
em.BusinessEntityID=pho.BusinessEntityID
where p.BusinessEntityID=@businessentityid;
end;
exec information 1;
/*Q4: what are system defined stored procedure , list any five and explain.*/
--sp_help : this stored procedure provides information about a database object,such as 
tables,views and also on.
--sp_rename :it is used to rename database objects such as tables,columns,views,indexes,
constraints.
--sp_who and sp_who2 : these two storted procedure tells current object running in a 
--session.
--sp_helptext : i will give source script of object.
--sp_helpindex:this storted procedure provides information about the indexes defined on a 
--table.
/*Q5: what type of triggers, and on what event you can pass trigger.*/
--types of triggers
--1.instead of trigger
--2.after trigger
--what event you can pass trigger
--on three event they can pass the trigger
--ddl
--dml
--logon
/*Q6: write about recursive trigger.*/
--a recursion triggers is a type of trigger that is designed to recursively exceute 
/*itself based on certain conditions.it is a trigger that,when fired,performs an action 
that triggers the same or a similar trigger again,creating a recursive loop where the 
trigger action triggers another instance of the trigger,leading to a chain of trigger 
executions.and recursive triggers are often used to automate complex data operations in 
a hierarchical data structure and recursion triggers is also called nested triggers */
/*Q7: explain importance of indexes, on OLTP system and OLAP system.*/
--importance of indexes,on oltp system and olap systems
--in indexes play importance on oltp(online transaction processing) and olap(online 
analytical processing)systems 
--indexes are essential for oltp system some reason such as 
1.improved /*Query performance
2.enhanced data integrity 
3.optimized joins 
--indexes are essential for olap system some reason such as 
1.performance optimization
2.materialized views
3.partitioning and indexing
/*Q7: what is difference between rowstore and columnstore indexes.*/
--difference between rowstore and columnstore indexes
--rowstore index columnstore index
--1.data is storted in a row wise format 1.data is storted in a column format
--2.better for oltp workloads 2.better for olap workloads
--3.better for smalltables 3.better for large tables
--4.less compressed 4.more compressed
--5 easier to update 5.more difficult to update
/*Q8: write script of merge join and write the importance.*/
create table customers(customerid int,customer_name varchar(1))
insert into customers values(1,'sai'),(2,'vishnu'),(3,'krishna'),(4,'vinay');
create table orders (orderid int,customerid int ,orderamount int);
insert into orders values (1,2,3300),(2,1,4500),(3,4,5600),(4,3,2300);
select c.customer_name,o.orderid,o.orderamount from customers c
inner join
orders o
on
c.customerid=o.customerid;
--importance of merge join
--1.joins large datasets
--2.sort data in proper manner
--3.ensures consistent and reliable /*Query results
--4.reduces the complexity of /*Query design and implementation.
/*Q9: Write the script for following: (10*5=50)
a. create stored procedure which take input parameter as businessentityid, then in output, you 
receive the information of that person. Choose as many related columns for that businessentityid 
from database adventureworks)
create procedure information
@businessentityid int
as
begin
select
p.BusinessEntityID,p.Title,p.FirstName,p.MiddleName,p.LastName,em.EmailAddress,pho.PhoneN
umber
from Person.Person p
inner join
HumanResources.Employee e
on
p.BusinessEntityID=e.BusinessEntityID
inner join
Person.EmailAddress em
on
e.BusinessEntityID=em.BusinessEntityID
inner join
person.PersonPhone pho
on
em.BusinessEntityID=pho.BusinessEntityID
where p.BusinessEntityID=@businessentityid;
end;
exec information 1;
b. Create audit stored procedure where, whenever insert update or delete command is executed on 
employee table, then at same time audit table is also populated with those records, and 
userid,username,curentdate and time value, sessionid.
create procedure audit_t
as
begin
insert into audit values( USER_ID(),USER_NAME(),cast(getdate() as date),cast(getdate() as
time),@@SPID)
end;
b. create stored procedure with input output and default parameter at same time, use any table, and 
parameters needed.
create procedure c
(@customerid int,
@customername varchar output,
@orderid int)
as
begin
select * from customers
where @customername=@customerid;
end;
/*d. create deterministic and non-deterministic user defined function, take any example.
--deterministic user defined function */
create function dbo.sum_of_two_numbers(@num1 int,@num2 int)
returns int
as
begin
 declare @result int
set @result=@num1+@num2
return @result
end;
select dbo.sum_of_two_numbers(4,2) as sum_of_two_numbers;
--non-deterministic user defined function
create function dbo.currentdateandtime()
returns datetime
as
begin
 declare @current datetime
set @current=GETDATE()
return @current
end;
select dbo.currentdateandtime() as currentdateandtime;
e. create user defined function so that if any column character length is checked then, user defined 
function gives output as length of characters for each row. 
create function dbo.check_data(@columncharacterlength varchar(30))
returns int
as
begin
declare @check varchar(30)
set @check=len(@columncharacterlength)
return @check
end;
select dbo.check_data('chennai') as length_of_character;
/*Q10: create triggers, to make audit table on DML operation. (use any table)(10)*/
create table audit_table(userid int,username varchar(30),currentdate date,currenttime 
time,sessionid int);
create trigger t_name on customers
for insert,update,delete
as
insert into audit_table values(
USER_ID(),USER_NAME(),cast(getdate() as date),cast(getdate() as time),@@SPID)
insert into customers values(5,'priya');
select * from audit_table;