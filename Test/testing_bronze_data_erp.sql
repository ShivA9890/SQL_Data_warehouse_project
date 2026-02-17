--Checking ERP of bronze layer

-- Checking cid
-- expected result : no result
select * from bronze.cust_az12
where cid not in (select cst_key from bronze.cust_info);

--checking valid bdate

select bdate from bronze.cust_az12
where bdate > getdate();

--checking gender 

select distinct(gen) from bronze.cust_az12 group by gen;


--checking silver.loc_a101
--Checking valid  Cid
-- expected result: no result
select cid from bronze.loc_a101 where cid  not in (select cst_key from bronze.cust_info)

--checking distinct country

select distinct(cntry) from bronze.loc_a101


-- Checking silver.px_cat_g1v2
--checking unwanted spaces in cat, subcat, maintainence
-- Expectation: No Results
SELECT 
    * 
FROM bronze.px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT 
    maintenance 
FROM bronze.px_cat_g1v2;