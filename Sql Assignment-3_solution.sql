create database sample1;
use sample1;
create table sales(orderid int primary key,customerid int,orderdate date,productid int,quantity int,price float,discount float);
insert into sales(orderid,customerid,orderdate,productid,quantity,price,discount)
values(1,101,'2022-01-01',1,2,10.99,0.05),(2,102,'2022-01-02',2,1,24.99,0),(3,103,'2022-01-03',1,3,10.99,0.1),(4,104,'2022-01-04',3,2,49.99,0.2) ,(5,105,'2022-01-05',2,1,24.99,0.1),(6,106,'2022-01-06',3,3,49.99,0);

--1.retrieve all sales data from the sales table.
select * from sales;

--2.retrieve the total sales for each order.
select orderid,sum(quantity*price-(quantity*price*discount)) as 'total sales'
from sales 
group by orderid;

--3.retrieve the total sales for each product.
select  productid,sum(quantity*price -(quantity*price*discount)) as 'total sales' from sales
group by productid;

--4.retrieve the total sales for each customer
select customerid,sum(quantity * price - (quantity*price*discount)) as 'total sales' from sales
group by customerid;

--5.retrieve  the average discount rate for each product
select productid,AVG(discount) as average_discount from sales
group by productid;

--6.retrieve the number of orders placed by each customer
select customerid , count(orderid) as 'number of orders placed' from sales
group by customerid;

--7.retrieve the top 5 best-selling products in terms of revenue.
select products,revenue from
(select  productid as products,sum(quantity*price - (quantity*price*discount))as revenue , DENSE_RANK() over(order by sum(quantity*price-(quantity*price*discount))desc)rnk from sales 
group by productid)t1
where rnk <=5;

--8.retrieve the top 5 customers who have made the most purchases.
select customerid,purchases from 
(select customerid,sum(quantity*price-(quantity*price*discount)) purchases, DENSE_RANK() over(order by sum(quantity*price-(quantity*price*discount))desc)rnk from sales
group by customerid)t2
where  rnk <=5;

--9.retrieve the total sales for each month in 2022.
select MONTH(orderdate)as 'month', sum(quantity*price-(quantity*price*discount)) as 'total sales' from sales
where YEAR(orderdate)=2022
group BY MONTH(orderdate);

--10.retrieve the customer who has made the most purchases in each month of 2022
select  customerid,max(productid)as purchases,MONTH(orderdate) as 'month' from sales
where year(orderdate)=2022
group by customerid,MONTH(orderdate)
order by max(productid) desc;

--11.retrieve the customers who have made at least one purchase of each product.
select  customerid,productid as purchase from sales
group by customerid, productid
having productid =1;















