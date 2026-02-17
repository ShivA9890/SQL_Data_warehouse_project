/*
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer.
*/

-- ====================================================================
-- Checking 'gold.customers_key'
-- ====================================================================
-- Check for Uniqueness of Customer Key in gold.customer_information
-- Expectation: No results 

SELECT * FROM gold.customer_information;

SELECT 
    id,
    COUNT(*) AS duplicate_count
FROM gold.customer_information
GROUP BY id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.product_information
-- Expectation: No results 
SELECT * FROM gold.product_information;

SELECT 
    product_id,
    COUNT(*) AS duplicate_count
FROM gold.product_information
GROUP BY product_id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.sales_table'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.sales_table f
LEFT JOIN gold.customer_information c
ON c.customer_id = f.customer_id
LEFT JOIN gold.product_information p
ON p.product_key = f.Product_catogory
WHERE p.product_key IS NULL OR c.customer_key IS NULL  