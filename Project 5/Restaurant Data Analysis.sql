										-- RESTAURANT DATA ANALYSIS --
                                        
USE restaurant_db;

# View the tables 

SELECT * FROM `restaurant_db`.menu_items;
SELECT * FROM `restaurant_db`.order_details;

# Find the number item of Menu
SELECT COUNT(*) AS number_items
FROM `restaurant_db`.menu_items;

# Top 3 Expensive Menu

SELECT * FROM `restaurant_db`.menu_items
ORDER BY price DESC
LIMIT 3;

# The Most Expensive Italian Menu

SELECT * FROM `restaurant_db`.menu_items
WHERE category = "Italian"
ORDER BY price DESC
LIMIT 1;

# The Most Expensive Asian Menu

SELECT * FROM `restaurant_db`.menu_items
WHERE category = "Asian"
ORDER BY price DESC
LIMIT 1;

# Total dishes in each category

SELECT category, count(menu_item_id) AS total_dishes
FROM `restaurant_db`.menu_items
GROUP BY category;

# Average Price Dishes in each category

SELECT category, AVG(price) AS average_price
FROM `restaurant_db`.menu_items
GROUP BY category;

# Date Range of Orders 

SELECT MIN(order_date), MAX(order_date) 
FROM `restaurant_db`.order_details;

# Items were ordered in this Date Range

SELECT Count(*) AS ordered_item
FROM `restaurant_db`.order_details;

# Which orders had the most number of items?

SELECT order_id, COUNT(item_id) AS num_items
FROM `restaurant_db`.order_details
GROUP BY order_id
ORDER BY num_items DESC
LIMIT 1;

# How many orders had more than 12 items?

SELECT COUNT(*) AS num_orders 
FROM (SELECT order_id, COUNT(item_id) AS num_items
FROM `restaurant_db`.order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders
;

# Combine the menu_items and order_details

SELECT * FROM `restaurant_db`.menu_items AS menu
	LEFT JOIN `restaurant_db`.order_details AS orders
	ON menu.menu_item_id = orders.order_details_id;
    
# Top 3 Dishes Most Purchased 

SELECT item_name, order_id, category, SUM(price) AS Total_Cost
FROM `restaurant_db`.menu_items AS menu
LEFT JOIN `restaurant_db`.order_details AS orders
ON menu.menu_item_id = orders.order_details_id
	GROUP BY item_name, order_id, category
    ORDER BY Total_Cost DESC
    LIMIT 3;










