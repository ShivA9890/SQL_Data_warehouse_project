CREATE OR ALTER PROCEDURE create_erp_silver_tables
AS
BEGIN

    /* =========================
       Customer AZ12 (Silver)
    ========================= */
    IF OBJECT_ID('silver.cust_az12', 'U') IS NULL
    BEGIN
        CREATE TABLE silver.cust_az12 (
            cid VARCHAR(50),
            bdate DATE,
            gen VARCHAR(50),
            create_date DATETIME DEFAULT GETDATE()
        );
    END;

    /* =========================
       Location A101 (Silver)
    ========================= */
    IF OBJECT_ID('silver.loc_a101', 'U') IS NULL
    BEGIN
        CREATE TABLE silver.loc_a101 (
            cid VARCHAR(50),
            cntry VARCHAR(50),
            create_date DATETIME DEFAULT GETDATE()
        );
    END;

    /* =========================
       Product Category G1V2 (Silver)
    ========================= */
    IF OBJECT_ID('silver.px_cat_g1v2', 'U') IS NULL
    BEGIN
        CREATE TABLE silver.px_cat_g1v2 (
            id VARCHAR(50),
            cat VARCHAR(50),
            subcat VARCHAR(50),
            maintenance VARCHAR(50),
            create_date DATETIME DEFAULT GETDATE()
        );
    END;

END;
GO
