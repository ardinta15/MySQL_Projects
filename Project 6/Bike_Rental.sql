										-- Bike Rental Shop --

CREATE DATABASE Bike_Rental;

CREATE TABLE `Bike_Rental`.customer
(	id				INT PRIMARY KEY,
	customer_name	VARCHAR(30),
	email			VARCHAR(50)
);

INSERT INTO `Bike_Rental`.customer (id, customer_name, email)
VALUES
(1,	'John Doe',	'john.doe@example.com'),
(2,	'Alice Smith','alice.smith@example.com'),
(3,	'Bob Johnson','bob.johnson@example.com'),
(4,	'Eva Brown', 'eva.brown@example.com'),
(5,	'Michael Lee', 'michael.lee@example.com'),
(6,	'Sarah White', 'sarah.white@example.com'),
(7,	'David Wilson', 'david.wilson@example.com'),
(8,	'Emily Davis', 'emily.davis@example.com'),
(9,	'Daniel Miller', 'daniel.miller@example.com'),
(10,'Olivia Taylor', 'olivia.taylor@example.com');

SELECT * FROM `Bike_Rental`.customer;

CREATE TABLE `Bike_Rental`.bike
(	id				INT PRIMARY KEY,
	model			VARCHAR(50),
	category		VARCHAR(50),
	price_per_hour	DECIMAL,
	price_per_day	DECIMAL,
    stat			VARCHAR (20)
    
);

INSERT INTO `Bike_Rental`.bike (id, model, category, price_per_hour, price_per_day, stat)
VALUES
(1,	'Mountain Bike 1', 'mountain bike', 10.00, 50.00, 'available'),
(2,	'Road Bike 1' ,'road bike', 12.00, 60.00, 'available'),
(3,	'Hybrid Bike 1','hybrid', 8.00, 40.00, 'rented'),
(4,	'Electric Bike 1','electric', 15.00, 75.00, 'available'),
(5,	'Mountain Bike 2','mountain bike', 10.00, 50.00	,'out of service'),
(6,	'Road Bike 2','road bike',12.00	,60.00,'available'),
(7,	'Hybrid Bike 2','hybrid'	,8.00	,40.00	,'out of service'),
(8,	'Electric Bike 2','electric',15.00	,75.00	,'available'),
(9,	'Mountain Bike 3','mountain bike'	,10.00	,50.00	,'rented'),
(10,'Road Bike 3','road bike',12.00	,60.00	,'available');

SELECT * FROM `Bike_Rental`.bike;

CREATE TABLE `Bike_Rental`.rental
(	id				INT PRIMARY KEY,
	customer_id		INT REFERENCES customer(id),
	bike_id			INT REFERENCES bike(id),
	start_timestamp	TIMESTAMP,
	duration		INT,
    total_paid		DECIMAL
);

INSERT INTO `Bike_Rental`.rental (id, customer_id, bike_id, start_timestamp, duration, total_paid)
VALUES
(1,	1,	1,	'2022-11-01 10:00:00',	240,	50.00),
(2,	1,	1,	'2022-11-02 10:00:00',	245,	50.00),
(3,	1,	1,	'2022-11-03 10:00:00',	250,	50.00),
(4,	1,	1,	'2022-11-04 10:00:00',	235,	50.00),
(5,	1,	1,	'2022-12-05 10:00:00',	155,	50.00),
(6,	2,	2,	'2022-12-08 11:00:00',	250,	60.00),
(7,	3,	3,	'2022-12-13 12:00:00',	245,	40.00),
(8,	1,	1,	'2023-01-05 10:00:00',	240,	50.00),
(9,	2,	2,	'2023-01-08 11:00:00',	235,	60.00),
(10,	3,	3,	'2023-02-13 12:00:00',	245,	40.00),
(11,	1,	1,	'2023-03-05 10:00:00',	250,	50.00),
(12,	2,	2,	'2023-03-08 11:00:00',	355,	60.00),
(13,	3,	3,	'2023-04-13 12:00:00',	240,	40.00),
(14,	1,	1,	'2023-04-01 10:00:00',	235,	50.00),
(15,	1,	6,	'2023-05-01 10:00:00',	245,	60.00),
(16,	1,	2,	'2023-05-01 10:00:00',	250,	60.00),
(17,	1,	3,	'2023-06-01 10:00:00',	235,	40.00),
(18,	1,	4,	'2023-06-01 10:00:00',	255,	75.00),
(19,	1,	5,	'2023-07-01 10:00:00',	240,	50.00),
(20,	2,	2,	'2023-07-02 11:00:00',	445,	60.00),
(21,	3,	3,	'2023-07-03 12:00:00',	250,	40.00),
(22,	4,	4,	'2023-08-04 13:00:00',	235,	75.00),
(23,	5,	5,	'2023-08-05 14:00:00',	555,	50.00),
(24,	6,	6,	'2023-09-06 15:00:00',	240,	60.00),
(25,	7,	7,	'2023-09-07 16:00:00',	245,	40.00),
(26,	8,	8,	'2023-09-08 17:00:00',	250,	75.00),
(27,	9,	9,	'2023-10-09 18:00:00',	335,	50.00),
(28,	10,	10,	'2023-10-10 19:00:00',	255,	60.00),
(29,	10,	1,	'2023-10-10 19:00:00',	240,	50.00),
(30,	10,	2,	'2023-10-10 19:00:00',	245,	60.00),
(31,	10,	3,	'2023-10-10 19:00:00',	250,	40.00),
(32,	10,	4,	'2023-10-10 19:00:00',	235,	75.00);

SELECT * FROM `Bike_Rental`.rental;

CREATE TABLE `Bike_Rental`.membership_type
(	id				INT PRIMARY KEY,
	customer_name	VARCHAR (50),
	description		VARCHAR (500),
	price			DECIMAL
);

INSERT INTO `Bike_Rental`.membership_type (id, customer_name, description, price)
VALUES
(1,'Basic Monthly',	'Unlimited rides with non-electric bikes. Renews monthly.',	100.00),
(2,'Basic Annual',	'Unlimited rides with non-electric bikes. Renews annually.',500.00),
(3,'Premium Monthly',	'Unlimited rides with all bikes. Renews monthly.',	200.00);

SELECT * FROM `Bike_Rental`.membership_type;

CREATE TABLE `Bike_Rental`.membership
(	id					INT PRIMARY KEY,
	membership_type_id	INT REFERENCES membership_type(id),
	customer_id			INT REFERENCES customer(id),
	start_date			DATE,
    end_date			DATE,
    total_paid			DECIMAL
);

INSERT INTO `Bike_Rental`.membership (id, membership_type_id, customer_id, start_date, end_date, total_paid)
VALUES
(1,	2,	3,	'2023-08-01',	'2023-08-31',	500.00),
(2,	1,	2,	'2023-08-01',	'2023-08-31',	100.00),
(3,	3,	4,	'2023-08-01',	'2023-08-31',	200.00),
(4,	1,	1,	'2023-09-01',	'2023-09-30',	100.00),
(5,	2,	2,	'2023-09-01',	'2023-09-30',	500.00),
(6,	3,	3,	'2023-09-01',	'2023-09-30',	200.00),
(7,	1,	4,	'2023-10-01',	'2023-10-31',	100.00),
(8,	2,	5,	'2023-10-01',	'2023-10-31',	500.00),
(9,	3,	3,	'2023-10-01',	'2023-10-31',	200.00),
(10,	3,	1,	'2023-11-01',	'2023-11-30',	200.00),
(11,	2,	5,	'2023-11-01',	'2023-11-30',	500.00),
(12,	1,	2,	'2023-11-01',	'2023-11-30',	100.00);

SELECT * FROM `Bike_Rental`.membership;


# 1. How many bikes the shop owns by category? 
-- (Show only the categories where the number of bikes is greater than 2)

SELECT category, Count(1) AS number_of_bikes 
FROM `Bike_Rental`.bike
GROUP BY category
HAVING Count(1) > 2;

# 2. Customer Names with the total Number of Memberships Purchased by each.

SELECT customer_name, count(m.id) AS membership_count 
FROM `Bike_Rental`. membership m
RIGHT JOIN `Bike_Rental`.customer c ON c.id=m.customer_id
GROUP BY customer_name
ORDER BY count(1) DESC;

# 3. Prepare a list of new rental prices

-- For each bike, display its ID, category, old price per hour (call this column old _price per hour ), 
-- discounted price per hour (call it new price per hour ), 
-- old price per day (call it old price per day ), 
-- and discounted price per day (call it new price per day ).

-- Electric bikes should have a 10% discount for hourly rentals and a 20% discount for daily rentals
-- Mountain bikes should have a 20% discount for hourly rentals and a 50% discount for daily rentals
-- All other bikes should have a 50% discount for all types of rentals.

SELECT id, category, price_per_hour AS old_price_per_hour,
CASE WHEN category = 'electric' THEN Round(price_per_hour - (price_per_hour*0.1) ,2)
	 WHEN category = 'mountain bike' THEN Round(price_per_hour - (price_per_hour*0.2) ,2)
	 ELSE Round(price_per_hour - (price_per_hour*0.5) ,2)
  END AS new_price_per_hour,
price_per_day as old_price_per_day,
CASE WHEN category = 'electric' THEN Round(price_per_day - (price_per_day*0.2) ,2)
	 WHEN category = 'mountain bike' THEN Round(price_per_day - (price_per_day*0.5) ,2)
	 ELSE Round(price_per_day - (price_per_day*0.5) ,2)
  END AS new_price_per_day
FROM `Bike_Rental`.bike;

# 4. Total Revenue from Rentals by month, the total by year, and the all-time across all the years.

SELECT extract(year from start_timestamp) AS year
, extract(month from start_timestamp) AS month
, sum(total_paid) AS revenue
FROM `Bike_Rental`.rental
GROUP BY rollup(year, month)
ORDER BY year, month;

# 5. Segment Customers based on the Number of Rentals

-- Categorize customers based on their rental history as follows: --
-- Customers who have had more than 10 rentals are categorized as 'more than 10'
-- Customers who have had 5 to 10 rentals (inclusive) are categorized as 'between 5 and 10'
-- Customers who have had fewer than 5 rentals should be categorized as 'fewer than 5'
-- Calculate the number of customers in each category. --
-- Display two columns:
-- - rental_count_category (the rental count category)
-- - customer_count (the number of customers in each category).

WITH cte AS 
    (Select customer_id, count(1),
		Case When count(1) > 10 Then 'more than 10' 
			 When count(1) Between 5 and 10 Then 'between 5 and 10'
			 Else 'fewer than 5'
	END AS category
	FROM `Bike_Rental`.rental
    GROUP by customer_id
    )
SELECT category AS rental_count_category,
Count(*) AS customer_count
FROM cte 
GROUP BY category
ORDER BY customer_count;













