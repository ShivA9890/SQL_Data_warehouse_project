# 🏗️ SQL Data Warehouse Project – Medallion Architecture

Welcome to the Data Warehouse Project repository! 🚀

A hands-on, end-to-end SQL learning and portfolio project focused on designing and building a data warehouse, implementing ETL processes, and performing analytics using modern industry-standard data engineering methodologies and best practices.
This project demonstrates an end-to-end Data Warehouse built using SQL Server and the Medallion Architecture (Bronze, Silver, Gold layers).  
It integrates data from multiple sources (CRM & ERP), performs transformations, and provides analytics-ready views for business reporting.

## 📌 Problem Statement

Organizations often have data scattered across multiple systems such as CRM and ERP.  
This leads to inconsistent reporting, poor data quality, and lack of a single source of truth.

This project solves these challenges by building a structured Data Warehouse that:
- Consolidates multi-source data
- Cleans and standardizes datasets
- Provides business-ready views for analytics

## 🧱 Architecture Overview

The warehouse follows the Medallion Architecture:

Source Systems → Bronze → Silver → Gold

Source Systems (CRM, ERP)
        │
        ▼
🥉 Bronze Layer  → Raw ingestion (as-is data)
        │
        ▼
🥈 Silver Layer  → Cleaned & standardized data
        │
        ▼
🥇 Gold Layer    → Business-ready views & analytics

## Bronze
### Purpose
- Store raw data from source systems
- Preserve original data for auditing

### Example Tables
- bronze.cust_info
- bronze.prd_info
- bronze.sales_info

## Silver
### Purpose
- Clean and standardize data
- Integrate multiple sources
- Add load timestamps

### Example Tables
- silver.cust_info
- silver.sales_info

## Gold
### Purpose
- Provide analytics-ready views
- Enable reporting & BI tools

### Example Views
- gold.customer_information
- gold.sales_table
- gold.product_information

## 🔄 ETL Workflow

1. Load raw CRM & ERP data into Bronze
2. Clean & standardize data in Silver
3. Build business views in Gold

## 🚀 How to Run

1. Create database
2. Run deployment script
3. Verify Gold views

## ⭐ Key Features

✔ Multi-source data integration  
✔ Bronze–Silver–Gold architecture  
✔ Automated ETL procedures  
✔ Analytics-ready views  
✔ Idempotent deployment scripts  
## 🔮 Future Enhancements

- Star schema (Fact & Dimension tables)
- Incremental loads
- Power BI dashboards
- Data quality checks


## 👨‍💻 Author

Shiv M  
Data Engineering Enthusiast | SQL Developer



