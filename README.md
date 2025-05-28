1. **Database Setup**
Database Creation: The project starts by creating a database named table1.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database retail_sales
use retail_sales
create table sales_data (transactions_id int NOT NULL PRIMARY KEY, sale_date DATE , sale_time TIME, customer_id int, 
gender varchar(15), age int, category varchar(20), quantity int, price_per_unit float, cogs float, total_sale float)
```

2. **Data Exploration & Cleaning**
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.


3. **Data Analysis & Findings**
The following SQL queries were developed to answer specific business questions:

Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
```sql
	select sale_date, total_sale from table1 where sale_date='2022-11-05'
```

Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
```sql
select sum(quantity) from table1 where category='Clothing' AND sale_date between '2022-11-01' AND '2022-11-30' AND quantity>=4 GROUP BY Category

select * from table1 where category='Clothing' AND sale_date between '2022-11-01' AND '2022-11-30' AND quantity>=4 
```

Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
```sql
select category,sum(total_sale) from table1 GROUP BY category
```

Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
```sql
select category,avg(age) from table1 where category='Beauty' GROUP BY category
```

Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
```sql
select * from table1 where total_sale>1000
```

Q.6 Write a SQL query to find the total number of transactions made by each gender in each category.
```sql
select gender,category,count(transactions_id) from table1 group by gender, category
```

Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
```sql
select year(sale_date), month(sale_date),avg(total_sale) as avg_sales, 
rank() over(partition by year(sale_date) order by avg(total_sale) desc) from table1 
group by month(sale_date), year(sale_date) ORDER BY avg_sales DESC
```

 Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
```sql
select customer_id, sum(total_sale) as sales from table1 GROUP BY customer_id ORDER BY sales DESC LIMIT 5
```

Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
```sql
select category,count(distinct(customer_id)) from table1 group by category
```

Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) #tricky

```sql
WITH hourly_sale AS
(select * ,
CASE WHEN hour(sale_time)<=12 THEN 'Morning'
     WHEN hour(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
     ELSE 'Evening'
END as shift     
from table1)
select shift,count(transactions_id) from hourly_sale GROUP BY shift
```

🔍 **Key Findings**
Customer Demographics: Sales span across diverse age groups and categories like Clothing and Beauty.
High-Value Transactions: Multiple purchases exceed ₹1000, pointing to premium customer segments.
Sales Trends: Monthly and shift-based trends highlight seasonal and time-based variations.
Customer Insights: Identifies top-spending customers and most popular product categories.

📈**Reports Generated**
Sales Summary: Total sales, demographic breakdown, and category performance.
Trend Analysis: Insights into monthly and shift-wise sales patterns.
Customer Reports: Unique customer counts by category and top customers by total spend.

✅ **Conclusion**
This analysis offers a structured approach to SQL-based data analysis, ideal for aspiring data analysts. It demonstrates how SQL can drive actionable insights into customer behavior, seasonal trends, and business performance.

