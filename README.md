# Brazil E-Commerce Sales Analysis Project

## Project Overview

This project analyzes the Olist Brazilian E-Commerce dataset to evaluate sales performance, customer activity, regional performance, product performance, delivery efficiency, and customer satisfaction.

SQL Server was used to join, aggregate, and analyze the data. Power BI was used to build an interactive dashboard that gives management a centralized view of business performance and operational trends.

Tools Used:
* SQL Server
* Power BI
* Power Query

---

## Business Problem

The company lacked a centralized reporting solution for monitoring revenue, orders, customers, product categories, regional performance, delivery times, and customer reviews.

The analysis was designed to answer the following business questions:

* How much revenue is the company generating?
* How are revenue and orders changing over time?
* Which states contribute the most revenue?
* Which product categories generate the most sales?
* Which regions have the highest average order values?
* How does delivery time relate to customer review scores?
* Which areas represent the strongest growth or operational-improvement opportunities?

---

## Dashboard Preview

![Dashboard](BrazilDataDashboard1.JPG)

---

## Key KPIs

| KPI | Value |
|------|---------|
| Total Revenue | $16.0M |
| Total Orders | 99,441 |
| Total Customers | 96,096 |
| Average Order Value | $160.99 |
| Average Review Score | 4.1 |
| Average Delivery Time | 12.4 Days |

---
KPI Defintions:

* Total Revenue: Sum of all recorded customer payment values
* Total Orders: Count of unique orders
* Total Customers: Count of unique customers
* Average Order Value: Total revenue divided by total orders
* Average Review Score: Average customer review score across completed orders
* Average Delivery Time: Average number of days between purchase and delivery

---

## Key Insights

### 1. São Paulo Is the Company’s Largest Revenue Market

São Paulo generated approximately 37% of total company revenue.

Its average order value was relatively moderate, indicating that its strong performance was driven primarily by high order volume rather than unusually large purchases.

This makes São Paulo the company’s most important market for customer retention, logistics reliability, and revenue protection.

### 2. Acre Has High-Value Customers but Low Sales Volume

Acre ranked near the bottom in total revenue but had the second-highest average order value at approximately $242.90.

This suggests that Acre may contain a smaller customer base with comparatively high-value purchasing behavior.

The state may represent a targeted growth opportunity, although its low order volume means further analysis would be required before making a major investment.

### 3. Revenue Is Concentrated in a Small Number of Product Categories

The top 10 product categories generated more than 60% of total revenue.

This concentration provides clear priority areas for inventory, marketing, and supplier management, but it also creates dependency risk if demand declines within the strongest categories.

### 4. Order Volume and Revenue Do Not Always Move Together

Some categories generated relatively high order volume without producing similarly high revenue.

For example, the electronics category ranked higher in order volume than in total revenue, suggesting a lower average revenue per order compared with stronger-performing categories.

This indicates that product performance should be evaluated using both order volume and revenue.

### 5. Longer Delivery Times Are Associated With Lower Review Scores

Orders with longer delivery times generally received lower customer review scores.

This relationship suggests that delivery speed and reliability may influence customer satisfaction.

The analysis identifies an association rather than proving that delivery time alone caused the lower reviews.

---

## Business Recommendations

### 1. Prioritize São Paulo for customer retention and logistics optimization because it is 
the company’s largest revenue market.  
### 2. Investigate Acre further to determine whether targeted marketing could increase 
order volume while maintaining its high average order value. 
### 3. Protect and expand the top-performing product categories but monitor dependency 
risk by identifying emerging categories with growth potential.  
### 4. Improve delivery speed and reliability, especially for orders at risk of long delivery 
times, because delayed deliveries appear linked to lower review scores.  
### 5. Analyze one-star reviews in more detail to identify recurring complaints related to 
delivery, product quality, or customer service.

---

## SQL Analysis

Example:

```sql
WITH TotalRevenue AS ( 
  SELECT 
  FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS OrderMonth, 
  SUM(op.payment_value) AS revenue 
FROM order_payments op 
JOIN orders o 
  ON op.order_id = o.order_id 
GROUP BY  
 FORMAT(o.order_purchase_timestamp, 'yyyy-MM') 
) 
 
SELECT  
  OrderMonth, 
  revenue, 
  ROUND( 
    (revenue - LAG(revenue) OVER (ORDER BY OrderMonth)) 
    * 100 / 
    LAG(revenue) OVER (ORDER BY OrderMonth), 
 2 
 ) AS PercentageChange  
FROM TotalRevenue 
ORDER BY OrderMonth

```
---

## Conclusion

The analysis found that revenue is heavily concentrated in São Paulo and a limited number of product categories, while certain smaller markets such as Acre demonstrate high average order values.

It also found that longer delivery times are associated with lower customer review scores, making logistics performance an important area for operational improvement.

The strongest immediate business priorities are protecting revenue in São Paulo, improving delivery reliability, investigating high-value regional opportunities, and reducing dependency on a narrow group of product categories.
