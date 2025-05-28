create database retail_sales
use retail_sales
-- create table sales_data (transactions_id int NOT NULL PRIMARY KEY, sale_date DATE , sale_time TIME, customer_id int, 
-- gender varchar(15), age int, category varchar(20), quantity int, price_per_unit float, cogs float, total_sale float)
select * from sales_data
select * from table1
select count(*) from table1

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select sale_date, total_sale from table1 where sale_date='2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select sum(quantity) from table1 where category='Clothing' AND sale_date between '2022-11-01' AND '2022-11-30' AND quantity>=4 GROUP BY Category 
-- OR
select * from table1 where category='Clothing' AND sale_date between '2022-11-01' AND '2022-11-30' AND quantity>=4 

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) from table1 GROUP BY category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category,avg(age) from table1 where category='Beauty' GROUP BY category


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from table1 where total_sale>1000


-- Q.6 Write a SQL query to find the total number of transactions made by each gender in each category.
select gender,category,count(transactions_id) from table1 group by gender, category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year(sale_date), month(sale_date),avg(total_sale) as avg_sales, 
rank() over(partition by year(sale_date) order by avg(total_sale) desc) from table1 
group by month(sale_date), year(sale_date) ORDER BY avg_sales DESC 


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as sales from table1 GROUP BY customer_id ORDER BY sales DESC LIMIT 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct(customer_id)) from table1 group by category 


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) #tricky
WITH hourly_sale AS
(select * ,
CASE WHEN hour(sale_time)<=12 THEN 'Morning'
     WHEN hour(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
     ELSE 'Evening'
END as shift     
from table1)
select shift,count(transactions_id) from hourly_sale GROUP BY shift
