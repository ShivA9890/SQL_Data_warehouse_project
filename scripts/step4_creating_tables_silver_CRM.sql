CREATE OR ALTER PROCEDURE create_silver_tables
AS
BEGIN

    /* =========================
       Customer Info (Silver)
    ========================= */
    IF OBJECT_ID('silver.cust_info', 'U') IS NULL
    BEGIN
        CREATE TABLE silver.cust_info (
            cst_id INT,
            cst_key VARCHAR(30),
            cst_firstName VARCHAR(50),
            cst_lastName VARCHAR(50),
            cst_marital_status VARCHAR(30),
            cst_gndr VARCHAR(30),
            cst_create_date DATE,
            cst_load_date DATE DEFAULT GETDATE()
        );
    END;

    /* =========================
       Product Info (Silver)
    ========================= */
    IF OBJECT_ID('silver.prd_info', 'U') IS NULL
    BEGIN
        CREATE TABLE silver.prd_info (
            prd_id INT,
            prd_key VARCHAR(50),
            id VARCHAR(50),
            cid VARCHAR(50),
            prd_name VARCHAR(50),
            prd_cost INT,
            prd_line VARCHAR(50),
            prd_start_date DATE,
            prd_end_date DATE,
            cst_load_date DATE DEFAULT GETDATE()
        );
    END;

    /* =========================
       Sales Info (Silver)
       Drop & Recreate if needed
    ========================= */
    IF OBJECT_ID('silver.sales_info', 'U') IS NOT NULL
    BEGIN
        DROP TABLE silver.sales_info;
    END;

    CREATE TABLE silver.sales_info (
        sls_odr_no VARCHAR(50),
        sls_prd_key VARCHAR(50),
        sls_cust_id VARCHAR(50),
        sls_order_date DATE,
        sls_ship_date DATE,
        sls_due_date DATE,
        sls_sales INT,
        sls_quantity INT,
        sls_price INT,
        cst_load_date DATE DEFAULT GETDATE()
    );

END;
GO
