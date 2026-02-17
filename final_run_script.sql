USE Datawarehouse;
GO

BEGIN TRY
    PRINT 'Initializing schemas...';
    EXEC initializing_datawarehouse;

    PRINT 'Creating Bronze tables...';
    EXEC create_crm_table;
    EXEC create_erp_tables;

    PRINT 'Loading Bronze data...';
    EXEC bronze.load_data_to_SQL_crm;
    EXEC bronze.load_data_to_SQL_erp;

    PRINT 'Creating Silver tables...';
    EXEC create_silver_tables;
    EXEC create_erp_silver_tables;

    PRINT 'Loading Silver layer...';
    EXEC silver.load_data_silver_layer;
    EXEC silver.load_data_to_silver_ERP;

    PRINT 'Creating Gold views...';
    EXEC create_view_customer_information;
    EXEC create_view_sales_table;
    EXEC create_view_product_table;

    PRINT 'Data Warehouse Initialization Completed Successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error occurred during deployment.';
    PRINT ERROR_MESSAGE();
END CATCH;
