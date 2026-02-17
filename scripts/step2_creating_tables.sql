CREATE OR ALTER PROCEDURE create_crm_table
AS
BEGIN
    SET NOCOUNT ON;

    -- Customer Info Table
    IF OBJECT_ID('bronze.cust_info', 'U') IS NULL
    BEGIN
        CREATE TABLE bronze.cust_info (
            cst_id INT,
            cst_key VARCHAR(30),
            cst_firstName VARCHAR(50),
            cst_lastName VARCHAR(50),
            cst_marital_status VARCHAR(30),
            cst_gndr VARCHAR(30),
            cst_create_date DATE
        );
    END;

    -- Product Info Table
    IF OBJECT_ID('bronze.prd_info', 'U') IS NULL
    BEGIN
        CREATE TABLE bronze.prd_info (
            prd_id INT,
            prd_key VARCHAR(50),
            prd_name VARCHAR(50),
            prd_cost INT,
            prd_line VARCHAR(50),
            prd_start_date DATE,
            prd_end_date DATE
        );
    END;

    -- Sales Info Table
    IF OBJECT_ID('bronze.sales_info', 'U') IS NULL
    BEGIN
        CREATE TABLE bronze.sales_info (
            sls_odr_no VARCHAR(50),
            sls_prd_key VARCHAR(50),
            sls_cust_id INT,
            sls_order_date DATE,
            sls_ship_date DATE,
            sls_due_date DATE,
            sls_sales INT,
            sls_quantity INT,
            sls_price INT
        );
    END;

END;
GO
