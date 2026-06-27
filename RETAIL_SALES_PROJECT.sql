--SQL PROJECTS RETAILS SALES----


CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS  NULL
      OR
     SALE_DATE IS NULL
	 OR
	 SALE_TIME IS NULL
	 OR
	 CUSTOMER_ID IS NULL
	 OR
	 GENDER IS NULL
	 OR
	 AGE IS NULL
	 OR
	 CATEGORY IS NULL 
	 OR
	 QUANTITY IS NULL
	 OR
	 COGS IS NULL
	 OR
	 TOTAL_SALE IS NULL


	 DELETE FROM RETAIL_SALES
	 WHERE TRANSACTIONS_ID IS  NULL
      OR
     SALE_DATE IS NULL
	 OR
	 SALE_TIME IS NULL
	 OR
	 CUSTOMER_ID IS NULL
	 OR
	 GENDER IS NULL
	 OR
	 AGE IS NULL
	 OR
	 CATEGORY IS NULL 
	 OR
	 QUANTITY IS NULL
	 OR
	 COGS IS NULL
	 OR
	 TOTAL_SALE IS NULL

	 SELECT COUNT(*)  FROM RETAIL_SALES


---DATA EXPLORATION

---- HOW MANY CUSTOMERS WEE HAVE

SELECT COUNT( DISTINCT CUSTOMER_ID) AS TOTAL_SALE FROM RETAIL_SALES

--HOW  MANY CATEGORY WE HAVEE
SELECT COUNT( DISTINCT CATEGORY) FROM RETAIL_SALES

-- Q1. DATA ANALYSIS & BUSSINESS KEY PROBLEMS & ANSWERS

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
*
FROM RETAIL_SALES
WHERE CATEGORY = 'BEAUTY'
AND 
TO_CHAR(SALE_DATE,'YYYY-MM') = '2022-11'
AND QUANTITY >= 4

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
     CATEGORY,
	 SUM(TOTAL_SALE) AS NET_SALE,
	
	 COUNT(*) AS TOTAL_ORDERS
	 FROM RETAIL_SALES
	 GROUP BY 1


--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
   ROUND (AVG (AGE),2) AS AVG_AGE
	 FROM RETAIL_SALES
	 WHERE CATEGORY = 'BEAUTY'
	 
--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

	 SELECT*FROM RETAIL_SALES
	 WHERE TOTAL_SALE> 1000
	 
--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
 CATEGORY,
 GENDER,
 COUNT(*)AS TOTAL_TRANS
 FROM RETAIL_SALES
 GROUP BY
  CATEGORY,
 GENDER
 ORDER BY 1


--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT YEAR,
MONTH,AVG_SALE
FROM

(
SELECT 
EXTRACT(YEAR FROM SALE_DATE)AS YEAR,
EXTRACT (MONTH FROM SALE_DATE) AS MONTH,
AVG(TOTAL_SALE)AS AVG_SALE,
RANK()OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE)DESC )
FROM RETAIL_SALES
GROUP BY 1,2)
AS T1 
WHERE RANK = 1


-- Q8. *Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT
      CUSTOMER_ID,
	  SUM(TOTAL_SALE) AS TOTAL_SALES
	  FROM RETAIL_SALES
	  GROUP BY 1
	  ORDER BY 2 DESC
	  LIMIT 5

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT
     CATEGORY,
	 COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUST
	 FROM RETAIL_SALES
	 GROUP BY CATEGORY

--Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH HOURLY_SALES
AS
(	 SELECT 
	      CASE
		  WHEN EXTRACT(HOUR FROM SALE_TIME)< 12 THEN 'MORNING'
		  WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON'
		  ELSE 'EVENING'
		  END AS SHIFT
		  FROM RETAIL_SALES
		  )
		  SELECT
		  SHIFT,
		  COUNT(*)AS TOTAL_ORDERS
		  FROM HOURLY_SALES
		  GROUP BY SHIFT

--END PROJECT--