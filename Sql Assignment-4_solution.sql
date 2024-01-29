--1.joins(use adventure works tables)
--a)write a query to display all the orders made by customers whose name starts with 
the letter 's', including the order number,customer name,and order date.use an inner 
join between the customers and orders tables.
--syntax: 
select O.order_number ,C.customer_name,O.order_date from customer C
inner join
orders O
on C.customerid=O.customerid
where C.customer_name like 's%';
--b)write a query to display the details of all the products sold by the company 
including the product name ,cateogory name,and unit price.use a left join between the 
products and categories tables.
--syntax:
select P.product_name,C.cateogory_name,P.unitprice from products P
left join
categories C
on P.productid=C.productid;
--c)write a query to display the total sales made by each employee in the year 
2022,including the employee name and the total sales.use a self-join on the orders 
table to calculate the total sales made by each employee.
--syntax:
select E.employee_name,sum(O.quantity*O.price)as total_sales from orders O
self join
orders E
on O.employeeid=E.employeeid
where year(O.orderdate)=2022
group by E.employee_name;
--d)using joins try to bring detailed information of employee,employee details are 
present in multiple tables like employee,address,payhistory etc.under human resource 
schema.
select * from HumanResources.Employee as E
inner join
HumanResources.EmployeePayHistory as P
ON
E.BusinessEntityID=P.BusinessEntityID;
--e)find the total sales for each territory,bring the names of terrritory as well as 
rank the total sales in descending order.
select t1.Name as territory_name,sum(SalesYTD) as total_sales,DENSE_RANK() over(order
by sum(SalesYTD) desc)as rnk from sales.SalesTerritory as t1
inner join
sales.SalesOrderHeader as t2
on t1.TerritoryID=t2.TerritoryID
group by t1.TerritoryID,t1.Name;
--2.subqueries,set operators,CTE:(populate table and dataset for the following 
question)
--a)write a query to display the names of all the customers who have placed orders for 
products with a unit price greater than $50. use a subquery to filter the results.
--syntax:
select customer_name from customertable
where CustomerID in(select CustomerID from orders where orderid from orderdetails 
where unitprice > $50);
--b)write a query to display the names of all the customers who have placed orders for 
products in the category'beverages',but have not placed any orders for products in the 
category'confections'.use set operators to combine the results of two subqueries.
--syntax:
select customer_name from customerstable
where customerid in (select customerid from orders where orderid from orderdetails 
where category='beverages')
except
select customer_name from customerstable
where customerid in (select customerid from orders where orderid from orderdetails 
where category='confections')
--c)write a query to display the details of the products that have been sold more 
than 500 units,including the product name,unit price,and total number of units 
sold.use a CTE to calculate the total number of units solds for each product,and then 
join the CTE with the products table.
--syntax:
with CTE as
( select productid,sum(quantity)as total_number_of_units from products
group by productid 
having sum(quantity)>500
)
select p.product_name,p.unit_price,c.total_number_of_units from product
inner CTE c on productid=productid;
--d) given a table 'sales' with columns 'product''quantity',and 'price',write a query 
to find the average price of all products that have a quantity greater than average 
quantity.
--syntax
with CTE as
(
select avg(quantity) as average_quantity from sales 
)
select AVG(price) as average_price from Sales 
where quantity > ( select average_quantity from CTE)
--e) given two tables'customers' and 'orders' with columns 'customerid' in both 
tables,write a query to retrieve the names of customers who have placed orders in the 
last 30 days.
--syntax:
select customer_name from customertable
where CustomerID in (select CustomerID from orders where OrderDate=DATEADD(day,-
30,OrderDate );
--f) given three tables 'employees','departments',and 'salaries' with 
columns'employeeid' in 'employees' and 'departments' and 'salary' in 'salaries',write 
a querey to find the average salary of employees in each deparment.
--syntax:
with CTE as
( deptid , avg(salary) average_salary from salaries
 group by deptid 
)
select average_salary from CTE ;
--g)given a table 'employees' with columns 'employeeid' and 'managerid',where 
'managerid' represents the manager of an employee,write a query to retrieve the names 
of all employees who report directly or indirectly to a specific manager.
--syntax:
select employee_name from
(
select * from employees_id where employee_id=mangagerid)
--h) given two tables 'orders' and 'orderdetails' with columns 'orderid' in both 
tables,write a query to calculate the total revenue for each order,along with the 
cutomer name and order date.
--syntax:
with CTE as
(sum(OD.quantity*OD.price)as total_revenue from orders O
INNER JOIN
orderdetails OD
on
O.orderid=OD.orderid
group by O.orderid,O.customername,O.orderdate)
select total_revenue from CTE 
--i) given a table 'products' with columns 'prodcutid','category'and 'price',write a 
query to rank the products within each category based on their price in descending 
order.
--syntax:
select ProductID,category,price, dense_rank() over(partition by category order by
price desc)rnk from products_table;