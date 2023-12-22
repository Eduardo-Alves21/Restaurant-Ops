-- Explore the items table

SELECT *
FROM menu_items

--
-- Write a query to find the number of items on the menu

SELECT 
	COUNT (menu_item_id)
FROM 
	menu_items

-- What are the least and most expensive items on the menu?

SELECT TOP(1) *
FROM
	menu_items
ORDER BY
	price ASC

SELECT TOP(1) *
FROM
	menu_items
ORDER BY
	price DESC

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?

SELECT 
	COUNT(*)
FROM 
	menu_items
WHERE
	category = 'Italian'

SELECT TOP(1) *
FROM 
	menu_items
WHERE 
	category = 'Italian'
ORDER BY 
	price ASC

SELECT TOP(1) *
FROM 
	menu_items
WHERE 
	category = 'Italian'
ORDER BY 
	price DESC

-- How many dishes are in each category? What is the average dish price within each category?

SELECT 
	category,
	COUNT (menu_item_id) as 'total dishes'
FROM
	menu_items
GROUP BY 
	category

SELECT 
	category,
	AVG (price) as 'avg price'
FROM
	menu_items
GROUP BY
	category


-- Explore the orders table

SELECT *
FROM order_details

-- View the order_details table. What is the date range of the table?

SELECT
	MIN(order_date) as 'Min_order_date',
	MAX(order_date) as 'Max_order_date'
FROM
	order_details

-- How many orders were made within this date range? How many items were ordered within this date range?

SELECT
	COUNT(DISTINCT order_id) as 'total_orders',
	COUNT(item_id) as 'total_items'
FROM
	order_details


-- Which orders had the most number of items?

SELECT
	order_id,
	COUNT(item_id) as 'total_items'
FROM
	order_details
GROUP BY
	order_id
ORDER BY
	COUNT(item_id) DESC

-- How many orders had more than 12 items?

SELECT
	COUNT(*) AS 'total_orders>12'
FROM
	(SELECT
		order_id,
		COUNT(item_id) as 'total_items'
	FROM
		order_details
	GROUP BY
		order_id
	HAVING 
		COUNT (item_id) > 12) AS num_orders


-- Analyze customer behavior

-- Combine the menu_items and order_details tables into a single table.

SELECT *
FROM 
	order_details
		LEFT JOIN	
			menu_items
				ON order_details.item_id = menu_items.menu_item_id;

-- What were the least and most ordered items? What categories were they in?

SELECT 
	item_name,
	category,
	COUNT(order_details_id) AS 'num_purchases'
FROM 
	order_details
		LEFT JOIN	
			menu_items
				ON order_details.item_id = menu_items.menu_item_id
GROUP BY
	item_name,
	category
ORDER BY
	num_purchases DESC
	
-- What were the top 5 orders that spent the most money?

SELECT TOP(5)
	order_id,
	SUM(price) AS 'total_spend'
FROM 
	order_details
		LEFT JOIN	
			menu_items
				ON order_details.item_id = menu_items.menu_item_id
GROUP BY
	order_id
ORDER BY
	total_spend DESC

-- View the details of the highest spend order. Which specific items were purchased?

SELECT 
	category,
	COUNT(item_id) as 'num_items'
FROM 
	order_details
		LEFT JOIN	
			menu_items
				ON order_details.item_id = menu_items.menu_item_id
WHERE 
	order_id = 440
GROUP BY
	category

-- View the details of the top 5 highest spend orders.

SELECT 
	order_id,
	category,
	COUNT(item_id) as 'num_items'
FROM 
	order_details
		LEFT JOIN	
			menu_items
				ON order_details.item_id = menu_items.menu_item_id
WHERE 
	order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY
	order_id,
	category
ORDER BY
	order_id
	


	




