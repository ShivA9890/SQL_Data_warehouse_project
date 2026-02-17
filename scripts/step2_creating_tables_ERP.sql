CREATE OR ALTER PROCEDURE create_erp_tables
AS
BEGIN
    -- Customer AZ12 Table
    IF OBJECT_ID('bronze.cust_az12', 'U') IS NULL
    BEGIN
        CREATE TABLE bronze.cust_az12 (
            cid VARCHAR(50),
            bdate DATE,
            gen VARCHAR(50)
        );
    END;

    -- Location A101 Table
    IF OBJECT_ID('bronze.loc_a101', 'U') IS NULL
    BEGIN
        CREATE TABLE bronze.loc_a101 (
            cid VARCHAR(50),
            cntry VARCHAR(50)
        );
    END;

    -- Product Category Table
    IF OBJECT_ID('bronze.px_cat_g1v2', 'U') IS NULL
    BEGIN
        CREATE TABLE bronze.px_cat_g1v2 (
            id VARCHAR(50),
            cat VARCHAR(50),
            subcat VARCHAR(50),
            maintenance VARCHAR(50)
        );
    END;

END;
GO
