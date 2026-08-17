# 🚀 SQL Data Warehouse Project

> An end-to-end **SQL Server Data Warehouse** built with **T-SQL**, following a layered architecture to transform raw CRM and ERP data into clean, structured, and business-ready data for analytics.

---

## 📌 Project Overview

This project demonstrates the development of a complete data warehouse using **SQL Server**.

Data is extracted from multiple **CRM and ERP source systems**, loaded into a raw staging layer, transformed through a cleaning layer, and finally organized into a business-ready analytical model.

### Main Objectives

- Build an end-to-end SQL Data Warehouse
- Integrate CRM and ERP data sources
- Apply a Bronze → Silver → Gold architecture
- Clean and standardize raw data
- Implement a dimensional model
- Perform data quality validation
- Create analytical reports
- Practice advanced SQL and T-SQL techniques

---

## 🏗️ Architecture

```text
                    CRM / ERP
                  Source Files
                       │
                       ▼
              ┌─────────────────┐
              │  BRONZE LAYER   │
              │    Raw Data     │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  SILVER LAYER   │
              │ Cleaned &       │
              │ Transformed Data│
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │   GOLD LAYER    │
              │ Business-Ready  │
              │     Data        │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │    ANALYTICS    │
              │    & REPORTS    │
              └─────────────────┘
🥉 Bronze Layer

The Bronze layer stores raw data loaded directly from CSV source files.

CRM Sources
Table	Description
crm_cust_info	Customer information
crm_prd_info	Product information
crm_sales_details	Sales transactions
ERP Sources
Table	Description
erp_customers	Customer demographic information
erp_Localisation	Customer country information
erp_category	Product category information

The Bronze layer uses BULK INSERT to load the source files.

The loading process is handled by:

EXEC bronze.load_bronze;
🥈 Silver Layer

The Silver layer contains cleaned and standardized data.

The transformation process includes:

Removing unnecessary spaces
Standardizing categorical values
Handling missing values
Validating dates
Standardizing customer identifiers
Cleaning product information
Correcting invalid sales values
Creating product validity periods
Applying business rules

The Silver layer contains cleaned versions of the Bronze tables.

The main loading procedure is:

EXEC Silver.load_silver;
🥇 Gold Layer

The Gold layer contains business-ready data designed for analytics and reporting.

The model follows a Star Schema consisting of dimensions and a central sales fact.

Dimensions
gold.dim_customers
gold.dim_products
Fact
gold.fact_sales
Analytical Reports
gold.report_customers
gold.report_products
⭐ Data Model
                    ┌──────────────────────┐
                    │    dim_customers     │
                    ├──────────────────────┤
                    │ customer_key         │
                    │ customer_id          │
                    │ customer_number      │
                    │ firstname             │
                    │ lastname              │
                    │ country               │
                    │ gender                │
                    │ marital_status        │
                    │ birthdate             │
                    └──────────┬───────────┘
                               │
                               │
                               ▼
                    ┌──────────────────────┐
                    │      fact_sales      │
                    ├──────────────────────┤
                    │ order_number         │
                    │ product_key          │
                    │ customer_id          │
                    │ order_date           │
                    │ ship_date             │
                    │ due_date              │
                    │ sales                 │
                    │ quantity              │
                    │ price                │
                    └──────────┬───────────┘
                               │
                               │
                               ▼
                    ┌──────────────────────┐
                    │     dim_products     │
                    ├──────────────────────┤
                    │ product_key          │
                    │ product_id           │
                    │ product_number       │
                    │ product_name         │
                    │ category              │
                    │ subcategory           │
                    │ product_cost         │
                    │ product_line         │
                    └──────────────────────┘
👥 Customer Dimension
gold.dim_customers

The customer dimension provides a business-friendly view of customer information.

It includes:

Customer key
Customer ID
Customer number
First name
Last name
Country
Gender
Marital status
Birthdate
Customer creation date
📦 Product Dimension
gold.dim_products

The product dimension provides product and category information.

It includes:

Product key
Product ID
Product number
Product name
Category
Subcategory
Maintenance
Product cost
Product line
Product start date
💰 Sales Fact
gold.fact_sales

The sales fact contains transactional information used for business analysis.

It includes:

Order number
Product key
Customer ID
Order date
Ship date
Due date
Sales
Quantity
Price
📊 Analytical Reports
👤 Customer Report
gold.report_customers

The customer report provides a complete customer-level overview.

Metrics
Customer age
Age group
Customer segment
Total orders
Total sales
Total quantity
Total products
Last order date
Customer lifespan
Average order value
Average monthly spend
Customer Segmentation
Segment	Definition
🏆 VIP	At least 12 months of activity and more than $5,000 in sales
⭐ Regular	At least 12 months of activity and up to $5,000 in sales
🆕 New	Less than 12 months of activity
📦 Product Report
gold.report_products

The product report provides a detailed overview of product performance.

Metrics
Product category
Product subcategory
Product cost
Last sale date
Sales recency
Product lifespan
Total orders
Total customers
Total sales
Total quantity
Average selling price
Average order revenue
Average monthly revenue
Product Segmentation
Segment	Definition
🏆 High-Performer	More than $50,000 in total sales
⭐ Mid-Range	Between $10,000 and $50,000 in total sales
📉 Low-Performer	Less than $10,000 in total sales
🔍 Data Quality

Data quality checks are implemented to validate the data throughout the warehouse.

Bronze & Silver Checks

The project validates:

Duplicate records
NULL primary keys
Invalid product categories
Invalid product costs
Invalid dates
Incorrect date sequences
Invalid quantities
Invalid prices
Incorrect sales calculations
Missing or inconsistent values
Gold Checks

The Gold layer is validated for:

Customer key uniqueness
Product key uniqueness
Fact-to-dimension connectivity
Referential integrity
Missing dimension records

Example:

SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;
📈 Exploratory Analysis

The project includes SQL queries for exploring business performance.

Customer Analysis
Customers by country
Customers by gender
Customer age range
Total customers
Active customers
Product Analysis
Products by category
Products by subcategory
Average product cost
Top-performing products
Lowest-performing products
Sales Analysis
Total sales
Total quantity sold
Average selling price
Total orders
Revenue by category
Revenue by customer
Sales by country
Ranking Analysis

SQL window functions are used to identify top-performing products and customers.

Example:

RANK() OVER (
    ORDER BY SUM(sales) DESC
)
🛠️ Technologies & Skills
Technology	Usage
SQL Server	Data warehouse platform
T-SQL	Data transformation and analysis
BULK INSERT	Source data ingestion
Stored Procedures	ETL automation
Views	Analytical data models
CTEs	Query organization
Window Functions	Ranking and analytical calculations
Star Schema	Dimensional modeling
Data Quality Checks	Data validation
📁 Project Structure
sql-data-warehouse-project/
│
├── datasets/
│   ├── source_crm/
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   │
│   └── source_erp/
│       ├── CUST_AZ12.csv
│       ├── LOC_A101.csv
│       └── PX_CAT_G1V2.csv
│
├── scripts/
│   ├── init_database.sql
│   │
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   │
│   ├── silver/
│   │   └── proc_load_silver.sql
│   │
│   ├── gold/
│   │   ├── dim_customers.sql
│   │   ├── dim_products.sql
│   │   ├── fact_sales.sql
│   │   ├── report_customers.sql
│   │   └── report_products.sql
│   │
│   └── quality_checks/
│       ├── bronze_quality_checks.sql
│       └── gold_quality_checks.sql
│
├── analysis/
│   └── exploratory_analysis.sql
│
└── README.md
▶️ How to Run
1. Initialize the Database

Run:

CREATE DATABASE DataWarehouse;

Create the required schemas:

CREATE SCHEMA Bronze;
CREATE SCHEMA Silver;
CREATE SCHEMA Gold;
2. Create Bronze Tables

Run the Bronze DDL script.

3. Load Bronze Data

Execute:

EXEC bronze.load_bronze;
4. Transform Data into Silver

Execute:

EXEC Silver.load_silver;
5. Create Gold Views

Create:

gold.dim_customers
gold.dim_products
gold.fact_sales
6. Create Analytical Reports

Create:

gold.report_customers
gold.report_products
7. Run Data Quality Checks

Execute the validation scripts to verify data integrity.

8. Run Exploratory Analysis

Execute the queries in:

analysis/exploratory_analysis.sql

Note: Update the CSV file paths inside the Bronze loading procedure according to your local environment.

🎯 Project Goals

This project demonstrates an end-to-end Data Engineering and Business Intelligence workflow:

Raw Data
   ↓
Data Ingestion
   ↓
Data Cleaning
   ↓
Data Transformation
   ↓
Dimensional Modeling
   ↓
Data Quality Validation
   ↓
Business Reporting
   ↓
Analytics

The project focuses on building a reliable and maintainable SQL data warehouse that can support business analysis and reporting.

👩‍💻 Author

Chaima Sassi

Data Engineering | Business Intelligence
