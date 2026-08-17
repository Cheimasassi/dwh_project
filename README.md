# SQL Data Warehouse Project

This project is an end-to-end SQL data warehouse built using **SQL Server and T-SQL**.

The main goal is to take raw CRM and ERP data from CSV files, clean and transform it, and prepare it for analysis and reporting.

The project follows the **Bronze → Silver → Gold** architecture and uses a **Star Schema** in the Gold layer.

---

## Project Architecture

The data goes through three main layers:

```text
CSV Files
    |
    v
Bronze Layer
    |
    v
Silver Layer
    |
    v
Gold Layer
    |
    v
Analysis & Reporting
```

### Bronze Layer

The Bronze layer contains the raw data loaded from the source CSV files.

### CRM Sources

| Table               | Description          |
| ------------------- | -------------------- |
| `crm_cust_info`     | Customer information |
| `crm_prd_info`      | Product information  |
| `crm_sales_details` | Sales transactions   |

### ERP Sources

| Table              | Description                  |
| ------------------ | ---------------------------- |
| `erp_customers`    | Customer information         |
| `erp_Localisation` | Customer country information |
| `erp_category`     | Product category information |

The data is loaded using `BULK INSERT`.

The Bronze loading procedure can be executed with:

```sql
EXEC bronze.load_bronze;
```

---

## Silver Layer

The Silver layer is where the raw data is cleaned and standardized before being used in the Gold layer.

Some of the transformations include:

* Removing unnecessary spaces
* Handling missing values
* Standardizing customer identifiers
* Cleaning product information
* Standardizing categorical values
* Checking and correcting dates
* Checking sales values
* Creating product validity periods
* Applying business rules

The Silver layer contains the cleaned versions of the Bronze tables.

The loading procedure is:

```sql
EXEC Silver.load_silver;
```

---

## Gold Layer

The Gold layer contains the final data used for analysis.

It follows a **Star Schema** with two main dimensions and one fact table.

### Dimensions

* `gold.dim_customers`
* `gold.dim_products`

### Fact

* `gold.fact_sales`

### Reports

* `gold.report_customers`
* `gold.report_products`

---

## Data Model

```text
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
                  │ sales                │
                  │ quantity             │
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
                  │ category             │
                  │ subcategory          │
                  │ product_cost         │
                  │ product_line         │
                  └──────────────────────┘
```

---

## Customer Dimension

### `gold.dim_customers`

This dimension contains the main information about customers.

Columns include:

* Customer key
* Customer ID
* Customer number
* First name
* Last name
* Country
* Gender
* Marital status
* Birthdate
* Customer creation date

---

## Product Dimension

### `gold.dim_products`

This dimension contains product and category information.

Columns include:

* Product key
* Product ID
* Product number
* Product name
* Category
* Subcategory
* Maintenance
* Product cost
* Product line
* Product start date

---

## Sales Fact

### `gold.fact_sales`

This table contains the sales transactions used for analysis.

Columns include:

* Order number
* Product key
* Customer ID
* Order date
* Ship date
* Due date
* Sales
* Quantity
* Price

---

# Reports

## Customer Report

### `gold.report_customers`

This report combines customer information with sales activity.

The report includes:

* Customer age
* Age group
* Customer segment
* Total orders
* Total sales
* Total quantity
* Total products
* Last order date
* Customer lifespan
* Average order value
* Average monthly spend

### Customer Segmentation

| Segment | Definition                                                   |
| ------- | ------------------------------------------------------------ |
| VIP     | At least 12 months of activity and more than $5,000 in sales |
| Regular | At least 12 months of activity and up to $5,000 in sales     |
| New     | Less than 12 months of activity                              |

---

## Product Report

### `gold.report_products`

This report is used to look at product performance.

The report includes:

* Product category
* Product subcategory
* Product cost
* Last sale date
* Sales recency
* Product lifespan
* Total orders
* Total customers
* Total sales
* Total quantity
* Average selling price
* Average order revenue
* Average monthly revenue

### Product Segmentation

| Segment        | Definition                                 |
| -------------- | ------------------------------------------ |
| High-Performer | More than $50,000 in total sales           |
| Mid-Range      | Between $10,000 and $50,000 in total sales |
| Low-Performer  | Less than $10,000 in total sales           |

---

# Data Quality Checks

I also added SQL checks to make sure the data is valid at each stage of the warehouse.

The checks include:

* Duplicate records
* NULL primary keys
* Invalid product categories
* Invalid product costs
* Invalid dates
* Incorrect date sequences
* Invalid quantities
* Invalid prices
* Incorrect sales calculations
* Missing or inconsistent values

For the Gold layer, I also check:

* Customer key uniqueness
* Product key uniqueness
* Fact and dimension relationships
* Referential integrity
* Missing dimension records

For example:

```sql
SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;
```

---

# Exploratory Analysis

The project also contains SQL queries for exploring the data and answering basic business questions.

### Customer Analysis

* Customers by country
* Customers by gender
* Customer age range
* Total customers
* Active customers

### Product Analysis

* Products by category
* Products by subcategory
* Average product cost
* Top-performing products
* Lowest-performing products

### Sales Analysis

* Total sales
* Total quantity sold
* Average selling price
* Total orders
* Revenue by category
* Revenue by customer
* Sales by country

### Ranking Analysis

Window functions are used for ranking customers and products.

For example:

```sql
RANK() OVER (
    ORDER BY SUM(sales) DESC
)
```

---

# Technologies

| Technology              | Usage                            |
| ----------------------- | -------------------------------- |
| SQL Server              | Data warehouse                   |
| T-SQL                   | Data transformation and analysis |
| BULK INSERT             | Loading CSV files                |
| Stored Procedures       | ETL processes                    |
| Views                   | Analytical models                |
| CTEs                    | Query organization               |
| Window Functions        | Ranking and calculations         |
| Star Schema             | Data warehouse modeling          |
| SQL Data Quality Checks | Data validation                  |

---

# Project Structure

```text
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
```

---

# How to Run

### 1. Create the Database

Create the database in SQL Server:

```sql
CREATE DATABASE DataWarehouse;
```

Then create the schemas:

```sql
CREATE SCHEMA Bronze;
CREATE SCHEMA Silver;
CREATE SCHEMA Gold;
```

### 2. Create Bronze Tables

Run the Bronze DDL script:

```text
scripts/bronze/ddl_bronze.sql
```

### 3. Load the Bronze Layer

Run:

```sql
EXEC bronze.load_bronze;
```

### 4. Load the Silver Layer

Run:

```sql
EXEC Silver.load_silver;
```

### 5. Create the Gold Layer

Run the scripts for:

```text
gold.dim_customers
gold.dim_products
gold.fact_sales
```

### 6. Create the Reports

Run:

```text
gold.report_customers
gold.report_products
```

### 7. Run Data Quality Checks

Run the SQL scripts inside:

```text
scripts/quality_checks/
```

### 8. Run the Analysis

Finally, run:

```text
analysis/exploratory_analysis.sql
```

> **Note:** The CSV file paths in the Bronze loading procedure need to be updated depending on where the project is stored on your computer.

---

# Project Goal

The main goal of this project was to build a complete SQL data warehouse starting from raw CSV files and ending with data that can be used for business analysis.

The workflow is:

```text
Raw Data
   ↓
Data Ingestion
   ↓
Data Cleaning
   ↓
Data Transformation
   ↓
Data Modeling
   ↓
Data Quality Checks
   ↓
Business Reports
   ↓
Exploratory Analysis
```

This project helped me practice SQL Server, T-SQL, ETL processes, data cleaning, dimensional modeling, data quality checks, and analytical SQL queries.

---

# Author

**Chaima Sassi**

Data Engineering | Business Intelligence
