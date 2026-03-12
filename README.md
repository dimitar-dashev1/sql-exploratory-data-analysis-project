# Exploratory SQL Data Analysis Project

**📌 Summary**

This project involves a comprehensive analysis of a retail database using a set of SQL scripts, covering everything from basic data exploration to advanced window functions and reporting views. The goal is to replicate a real-world scenario by transforming raw data into actionable business insights and analyzing customer behavior, product performance, and sales trends.

Key Features

* Customer Segmentation: Categorized customers into 'VIP', 'Regular', and 'New' based on spending thresholds and account lifespan;
* Product Performance: Ranked products by revenue and identified high-performers vs. low-performers;
* Trend & Cumulative Analysis: Developed running totals and moving averages to track sales velocity over time;
* Automated Reporting: Created reusable VIEW objects for high-level Customer and Product KPI dashboards.

**🚀 Quick Start Guide**

**<ins>If you want, you can skip some of the steps below by using the `.bak` file provided in the folder [docs](./docs/).</ins>**

But if you are a beginner, just like me, you can follow these steps in your own SQL environment to practice:

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

2. Execution Order

Since some scripts depend on the existence of specific data structures, I recommend running them in this logical order:

  * Exploration: You can run scripts `00_database_exploration.sql` through `04_magnitude_analysis.sql` to get a feel for the data volume;
  * Analysis: Execute `05_ranking_analysis.sql`, `06_trend_analysis.sql`, `07_cumulative_analysis.sql`, `08_perfromance_analysis.sql`, and `09_part_to_whole_analysis.sql` to generate insights.
  * Segmentation: Run `10_data_segmentation_analysis.sql` and `11_data_segmentation_analysis_2.sql`.
  * Reporting: Finally, create the persistent reporting views by running `12_project_KPI_report_customers.sql` and `13_project_KPI_report_products.sql`

3. Verifying Results
 
Once the views are created in the previous steps, you can query them directly to see the processed KPIs:

```sql
SELECT * FROM dbo.customers_report;
SELECT * FROM dbo.products_report;
```

## 📊 The Analysis

I start off by outlining my thought process when examining the databases for the first time. As already mentioned, the repository includes scripts (00 through 04) needed to explore the data in detail (general structure, types of data, dimensions and measures). Once I complete this exploration, I have the clarity and confidence needed to begin modeling and analyzing the data.

**Part-to-Whole & Magnitude Analysis**

In `09_part_to_whole_analysis.sql`, I utilized `SUM(...) OVER()` to calculate a "Grand Total" that persists across every row. To calculate market share, I needed the category total divided by the global total. Here using a *window function* instead of a *subquery* improves execution speed on large datasets. This identified "Anchor Categories". For instance, "Bikes" represent 90% of revenue but only 10% of transaction volume, which mean that the business is highly dependent on high-ticket items.

**Customer Segmentation Logic**

In `11_data_segmentation_analysis_2.sql`, I applied complex `CASE` statements based on two variables: *Lifespan* and *Total Spending*. I also implemented the following logic to identify high-value long-term customers:

  * VIP: > 12 months history AND > €5,000 spent;
  * Regular: > 12 months history AND ≤ €5,000 spent;
  * New: < 12 months purchase history.

By calculating `DATEDIFF` between the first and last purchase, I filtered out customers who have spent a lot on a single purchase from truly loyal customers. This allows for <ins>Targeted Marketing</ins>. "New" customers with high spending are "Rising Stars" who should be fast-tracked into loyalty programs, while "Regular" long-term customers are "Steady Earners" who may respond well to upselling.

**Performance & YoY Analysis**

Using window functions (`LAG`, `OVER`, `PARTITION BY`), I calculated the deviation from average: how much a product's current sales differ from its historical average. Raw sales totals were not enough to tell the whole story. By partitioning the data by `product_name` and ordering by `order_year`, I could pull the previous year’s revenue into the current row. This reveals "momentum." A product might have high sales, but if the `dev_from_avg` is negative, it indicates a declining trend that requires marketing intervention.

**Reporting Views**
I consolidated complex logic into two primary reports:

  * `customers_report`: Tracks recency, average order value (AOV), and average monthly spend per customer;
  * `products_report`: Tracks product "lifespan" in the inventory and categorizes them by revenue contribution.

## 🛠️ What I Learned

1. Database Design: Implementing a Star Schema with fact and dimension tables;
2. Advanced SQL: Extensive use of CTEs, Window Functions (`RANK`, `SUM OVER`, `LAG`, `ROW_NUMBER`), and Data Aggregation;
3. Data Segmentation: Grouping data by multiple dimensions (Geography, Time, Category) using `CASE` logic;
4. Time-Series Analysis: Calculating Year-over-Year (YoY) growth and cumulative running totals.
5. Conditional Logic: Extensive use of CASE WHEN for data bucketing and segmentation;
6. Data Cleaning: Handling NULL values and formatting dates using DATETRUNC and DATEDIFF.
