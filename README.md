# Exploratory SQL Data Analysis Project

**📌 Summary**

This project involves a comprehensive analysis of a retail database using a set of SQL scripts, covering everything from basic data exploration to advanced window functions and reporting views. The goal is to replicate a real-world scenario by transforming raw data into actionable business insights and analyzing customer behavior, product performance, and sales trends.

Key Features

* Customer Segmentation: Categorized customers into 'VIP', 'Regular', and 'New' based on spending thresholds and account lifespan;
* Product Performance: Ranked products by revenue and identified high-performers vs. low-performers;
* Trend & Cumulative Analysis: Developed running totals and moving averages to track sales velocity over time;
* Automated Reporting: Created reusable VIEW objects for high-level Customer and Product KPI dashboards.

**🚀 Quick Start Guide**

If you are a beginner, just like me, you can follow these steps in your own SQL environment:
1. Prerequisites
* SQL Environment: Ensure you have access to a SQL Server instance (such as SQL Server Management Studio, used for this project);
* Database: Create a new database to host the sample tables;
```sql
CREATE DATABASE RetailAnalytics;
USE RetailAnalytics;
````
* Data Import: Ensure you have the fact_sales, dim_customers, and dim_products tables loaded into your database;
  **The analysis is built upon a Star Schema consisting of:**
    - `fact_sales`: Fact table with transactional data (sales, quantity, dates);
    - `dim_customers`: Dimensions table with demographics (age, gender, country);
    - `dim_products`: Dimensions table with product metadata (category, subcategory, cost).
[Download the datasets](./datasets/)

## The Analysis



