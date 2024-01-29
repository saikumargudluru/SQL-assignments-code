--1.create a database called "mydb"
create database mydb;
use mydb;

--2.create table called "users" with following columns id (integer),name (text),email (text),created_at (timestamp)
create table users(id int,name text , email text ,created_at datetime);

--3.insert 5 records into the "users" table 
insert into users(id,name,email,created_at)
values(1,'ravikumar','ravikumar@gmail.com','2022-01-01 10:00:00:000'),(2,'john','john@gmail.com','2022-02-01 11:00:00:000'),(3,'vinay','vinay@outlook.com','2022-03-01 12:00:00:000'),(4,'ganesh','ganesh@gmail.com','2022-04-01 13:00:00:000'),(5,'priya','priya@outlook.com','2023-01-01 14:00:00:000');

--4.write a select statement to retrieve all records from the "users" table
select * from users;

--5.write a select statement to retrieve all records from the "users" table where the name is "john"
select * from users 
where name like 'john';


--6.write a select statement to retrieve all records from the "users" table where the email contains '@gmail.com'
select * from users
where email like '%@gmail.com';

--7.use the date function to retrieve all records from the "users" table where the created_at date is after '2022-01-01'
select * from users
where cast(created_at AS date) > '2022-01-01';

--8.use the cast function to convert the id column to a character datatype and retrieve all records from the "users" table where id is greater than 3
 select  CAST(id AS varchar) as id,name,email,created_at from users
 where id>3;

--9.use the convert function to convert the created_at column to a character datatype and retrieve all records from the "users" table where created_at date is before '2023-01-01'
select id,name,email,convert(varchar,created_at) as created_at from users
where created_at < '2023-01-01';

--10.use the wild card function to retrieve all records from the 'users table where the name starts with 'j'
select * from users
where name like 'j%';



