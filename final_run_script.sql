/*
==========================================================
 Data Warehouse Final Run Script
==========================================================

Purpose:
This script orchestrates the full execution of the
Data Warehouse pipeline using Medallion Architecture.

Execution Flow:
1. Initialize schemas (Bronze, Silver, Gold)
2. Create Bronze tables and load raw data
3. Create Silver tables and perform transformations
4. Create Gold views for analytics

Safe to rerun: Yes (procedures are idempotent)

==========================================================
*/

-- Switch to the Datawarehouse database
USE Datawarehouse;
GO

BEGIN TRY

    ------------------------------------------------------
    -- STEP 1: Initialize Schemas
    -- Creates Bronze, Silver, and Gold schemas
    ------------------------------------------------------
    PRINT 'Initializing schemas...';
    EXEC initializing_datawarehouse;


    ------------------------------------------------------
    -- STEP 2: Create Bronze Tables
    -- Raw ingestion tables for CRM & ERP sources
    ------------------------------------------------------
    PRINT 'Creating Bronze tables...';
    EXEC create_crm_table;
    EXEC create_erp_tables;


    ------------------------------------------------------
    -- STEP 3: Load Bronze Layer
    -- Load raw data from source systems into Bronze
    ------------------------------------------------------
    PRINT 'Loading Bronze data...';
    EXEC bronze.load_data_to_SQL_crm;
    EXEC bronze.load_data_to_SQL_erp;


    ------------------------------------------------------
    -- STEP 4: Create Silver Tables
    -- Cleaned & standardized layer tables
    ------------------------------------------------------
    PRINT 'Creating Silver tables...';
    EXEC create_silver_tables;
    EXEC create_erp_silver_tables;


    ------------------------------------------------------
    -- STEP 5: Load Silver Layer
    -- Apply transformations and integrate data
    ------------------------------------------------------
    PRINT 'Loading Silver layer...';
    EXEC silver.load_data_silver_layer;
    EXEC silver.load_data_to_silver_ERP;


    ------------------------------------------------------
    -- STEP 6: Create Gold Views
    -- Business-ready views for analytics & reporting
    ------------------------------------------------------
    PRINT 'Creating Gold views...';
    EXEC create_view_customer_information;
    EXEC create_view_sales_table;
    EXEC create_view_product_table;


    ------------------------------------------------------
    -- SUCCESS MESSAGE
    ------------------------------------------------------
    PRINT 'Data Warehouse Initialization Completed Successfully.';

END TRY
BEGIN CATCH

    ------------------------------------------------------
    -- ERROR HANDLING
    -- Displays error message if any step fails
    ------------------------------------------------------
    PRINT 'Error occurred during deployment.';
    PRINT ERROR_MESSAGE();

END CATCH;
