--ANALYSIS QUESTIONS

CREATE database flipkart;

use flipkart;

SELECT * from flipkart_sales;


1--Retrieve the top 3 selling products by total revenue.

SELECT Top 3 product_name, SUM(Total_Sales_INR) AS total_sales
FROM flipkart_sales
GROUP BY product_name
ORDER BY total_sales DESC;

2--Find the top 3 most ordered products.
Select top 3 product_name, count(*) as total_orders
FROM flipkart_sales
GROUP BY 
    product_name
ORDER BY 
    total_orders DESC;

3--Retrieve the second highest revenue-generating product category

SELECT top 2 category, SUM(profit_INR) AS total_revenue
FROM flipkart_sales
GROUP BY category
ORDER BY total_revenue DESC;


4--Shows which payment methods are most popular for high-value orders
SELECT 
    payment_method, 
    COUNT(order_id) AS order_count, 
    AVG(price_inr) AS avg_order_value
FROM flipkart_sales
GROUP BY payment_method;

5--Total Revenue and Profit by Category

SELECT 
    category, 
    SUM(total_sales_inr) AS total_revenue, 
    SUM(profit_inr) AS total_profit
FROM flipkart_sales
GROUP BY category
ORDER BY total_revenue DESC;

6--Average Customer Rating per Region

SELECT 
    region, 
    AVG(customer_rating) AS avg_rating
FROM flipkart_sales
GROUP BY region;

7--Use the month and year columns to understand how sales fluctuate over time

SELECT 
    year, 
    month, 
    SUM(total_sales_inr) AS monthly_revenue
FROM flipkart_sales
GROUP BY year, month
ORDER BY year, month;

8-- Top 3 Best-Selling Products in Each Category Uses the RANK() window function to find the most popular items by volume.

SELECT * FROM (
    SELECT 
        product_name, 
        category, 
        SUM(quantity_sold) as total_qty,
        RANK() OVER(PARTITION BY category ORDER BY SUM(quantity_sold) DESC) as sales_rank
    FROM flipkart_sales
    GROUP BY product_name, category
) ranked_products
WHERE sales_rank <= 3;

9--dentifies which segment is more profitable relative to the discounts given.

SELECT 
    customer_segment, 
    SUM(total_sales_inr) AS total_sales,
    SUM(discount) AS total_discounts,
    (SUM(profit_inr) / SUM(total_sales_inr)) * 100 AS profit_margin_percent
FROM flipkart_sales
GROUP BY customer_segment;