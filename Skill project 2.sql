show tables;
-- Show the discription of table
desc skillnekisproject;
-- ### Data cleaning part
-- Rename column some mistake after import
alter table skillnekisproject rename column ï»¿order_id to  order_id;

-- retrive all data from table
select * from skillnekisproject;

-- show dublicate records
select order_id,customer_name,order_date,category,sub_category,product_name,quantity,unit_price,total_price,region,count(*) 'Count' from 
skillnekisproject group by order_id,customer_name,order_date,category,sub_category,product_name,quantity,unit_price,total_price,region
having count>1;
-- Show duplicate record in order
select order_id,count(*)'count' from skillnekisproject group by order_id having count>1;

-- To midify data type of order_id
alter table skillnekisproject modify column order_id int primary key;

-- Modify data type of unit_price
alter table skillnekisproject modify column unit_price decimal(10,2);
-- Formate of order_date
 update skillnekisproject set order_date= str_to_date(order_date,'%d-%m-%Y');

-- Modify the data type of order_date
alter table skillnekisproject modify column order_date date;

-- to modify the data type of total price
alter table skillnekisproject modify column total_price decimal;


-- ### Analysis part
-- Q1 Use select query to retrive data
select * from skillnekisproject;

-- Q2 Use where clause
select sum(total_price) 'sales' from skillnekisproject where category = 'Clothing';

--  Q3 Find top 10 buyers
select sub_category,sum(total_price)'Tshopping'
from skillnekisproject
group by sub_category order by Tshopping desc limit 10 ;

-- Q4 top seling category
select category,sum(total_price)'sale'
from skillnekisproject 
group by category 
order by sale 
desc limit 1;

-- Q5 Top  5 sub category selling product
select sub_category,sum(total_price) 'sale' 
from skillnekisproject
 group by sub_category 
 order by sale 
 desc limit 5  ;
 
-- Q6 category wise average sales
select  avg(total)'average' 
from (select category ,sum(total_price) 'total'from skillnekisproject group by category ) as sales  ;

-- Q7 Top 10 buying customer
select customer_name,sum(total_price)'Total' 
from skillnekisproject group by customer_name 
order by total 
desc limit 10;

-- Q8 Top 10 customer with lowest purchesh amount
select customer_name,sum(total_price)'Total' 
from skillnekisproject 
group by customer_name 
order by total asc limit 10;

-- Q9 Total order
select count(*)'Total_Orders' 
from skillnekisproject;

-- Q10 Average order quantity
select round(avg(quantity)) 'Average_quantity' 
from skillnekisproject ;

-- Q11 Total sales price
select sum(total_price) 'Total' from skillnekisproject;

-- Q12 Region wise sales
select  region, sum(total_price) 'Total' from skillnekisproject group by region order by  total desc;

-- Q13  Year wise order
select  distinct year(order_date) 'date',count(*)'order' from skillnekisproject group by date;

-- Q14 Year wise sales
select distinct year(order_date)'Year' ,sum(total_price) 'Total_sales' from skillnekisproject group by year;

