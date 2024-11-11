CREATE DATABASE Walmart_SalesData;

USE Walmart_SalesData;
CREATE TABLE Walmart_SalesData(
	invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

SELECT * FROM Walmart_SalesData.Walmart_SalesData;

-- Add the time_of_day column

SELECT time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM Walmart_SalesData.Walmart_SalesData;

ALTER TABLE Walmart_SalesData ADD COLUMN time_of_day VARCHAR(20);

UPDATE Walmart_SalesData
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


-- Add day_name column

SELECT date, DAYNAME(date) FROM Walmart_SalesData.Walmart_SalesData;

ALTER TABLE Walmart_SalesData ADD COLUMN day_name VARCHAR(10);

UPDATE Walmart_SalesData SET day_name = DAYNAME(date);

-- Add month_name column

SELECT date, MONTHNAME(date) FROM Walmart_SalesData;

ALTER TABLE Walmart_SalesData ADD COLUMN month_name VARCHAR(10);

UPDATE Walmart_SalesData SET month_name = MONTHNAME(date);




--- 										EXPLORATORY DATA ANALYSIS 							---

-- How many unique product lines does the data have?

SELECT DISTINCT product_line FROM Walmart_SalesData;

-- What is the most selling product line?

SELECT
	SUM(quantity) as qty,
    product_line
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY product_line
ORDER BY qty DESC;

-- Total revenue by month

SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY month_name 
ORDER BY total_revenue DESC;

-- What month had the largest COGS?

SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY month_name 
ORDER BY cogs DESC;

-- What product line had the largest revenue?

SELECT
	product_line,
	SUM(total) as total_revenue
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?

SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY city, branch 
ORDER BY total_revenue DESC;


-- Which branch sold more products than average product sold?

SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM Walmart_SalesData.Walmart_SalesData);

-- What is the most common product line by gender?

SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- Average Rating of Each Product Line

SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY product_line
ORDER BY avg_rating DESC;

-- How many unique customer types does the data have?

SELECT
	DISTINCT customer_type
FROM Walmart_SalesData.Walmart_SalesData;

-- How many unique payment methods does the data have?

SELECT
	DISTINCT payment
FROM Walmart_SalesData.Walmart_SalesData;

-- The most common Customer Type

SELECT
	customer_type,
	Count(*) AS Count
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY customer_type
ORDER BY count DESC;

-- Gender Distribution per Branch

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM Walmart_SalesData.Walmart_SalesData
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which Time of The Day do Customers Give Most Ratings?

SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which Time of The Day do Customers Give Most Ratings per Branch?

SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM Walmart_SalesData.Walmart_SalesData
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which Day of The Week has The Best Average Ratings per Branch?

SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM Walmart_SalesData.Walmart_SalesData
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;


-- Number of Sales Made in Each Time of The Day per Weekday

SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM Walmart_SalesData.Walmart_SalesData
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;


-- Which of the customer types brings the most revenue?

SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY customer_type
ORDER BY total_revenue;

-- Which City has The Largest Tax/VAT Percent?

SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?

SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM Walmart_SalesData.Walmart_SalesData
GROUP BY customer_type
ORDER BY total_tax;
 











