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


 
-- Business key Problems

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * 
FROM sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM sales
WHERE category = 'Clothing' 
	AND 
	quantiy >= 4
	AND 
	sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category, 
	SUM(total_sale) as total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(avg(age),2) as average_age
FROM sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of  transactions (transaction_id) made by each gender in each category.
SELECT category ,gender, count(transactions_id) as total_trans
FROM sales
GROUP BY category, gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) as total_sale
FROM sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category , COUNT(distinct customer_id) as customer_count
FROM sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
	
SELECT 
	CASE
		WHEN sale_time < '12:00:00' THEN 'Morning'
        WHEN sale_time >= '12:00:00' AND sale_time < '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END as shift,
    COUNT(*) AS num_orders
FROM sales
GROUP BY shift;
