# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure


### 1. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT * FROM sales;

UPDATE sales
SET sale_date = STR_TO_DATE(sale_date, '%d-%m-%Y');

SELECT 
    COUNT(*) 
FROM sales;

SELECT distinct gender
from sales;

SELECT distinct category
from sales;

-- Data Cleaning
SELECT * 
FROM sales
WHERE 
	transactions_id IS NULL
	OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR 
    gender IS NULL
    OR 
    age IS NULL
    OR 
    category IS NULL
    OR 
    quantiy IS NULL
    OR 
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
DELETE FROM sales
WHERE 
	transactions_id IS NULL
	OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR 
    gender IS NULL
    OR 
    age IS NULL
    OR 
    category IS NULL
    OR 
    quantiy IS NULL
    OR 
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;

-- Data Exploration

-- How many data we have?
SELECT count(*) FROM sales;

-- How many unique customer we have?
SELECT count(distinct customer_id) as total_customer 
FROM sales;

-- How many unique category we have?
SELECT count(distinct category)
FROM sales;

```

### 2. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. ** Write a SQL query to retrieve all columns for sales made on '2022-11-05'**:
```sql
SELECT * 
FROM sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM sales
WHERE category = 'Clothing' 
	AND 
	quantiy >= 4
	AND 
	sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	category, 
	SUM(total_sale) as total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(avg(age),2) as average_age
FROM sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * 
FROM sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of  transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category ,gender, count(transactions_id) as total_trans
FROM sales
GROUP BY category, gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**:
```sql
WITH monthly_avg AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTHNAME(sale_date) AS month,
        ROUND(AVG(total_sale),2) AS avg_sale
    FROM sales
    GROUP BY YEAR(sale_date), MONTHNAME(sale_date)
),
ranked as(
	SELECT 
		year,
		month,
		avg_sale,
		RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS ranking
	FROM monthly_avg
)
SELECT * 
FROM ranked
WHERE ranking = 1
ORDER BY year;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, SUM(total_sale) as total_sale
FROM sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category , COUNT(distinct customer_id) as customer_count
FROM sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT 
	CASE
		WHEN sale_time < '12:00:00' THEN 'Morning'
        WHEN sale_time >= '12:00:00' AND sale_time < '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END as shift,
    COUNT(*) AS num_orders
FROM sales
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.



## 🤝 **Let's Connect**

Found this project valuable? I'd love to connect and discuss how data analytics can transform your business!

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/varshik-jodhani-351a79292/)


<div align="center">

**Made with ❤️ and ☕ by Varshik Jodhani**

</div>
