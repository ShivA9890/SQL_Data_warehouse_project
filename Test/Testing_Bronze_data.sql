--Checking CRM data 

-- bronze.cust_info

-- check the null and duplicate in cst_id
SELECT 
    cst_id,
    COUNT(*) 
FROM bronze.cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--check the additional space and null in cst_key

select 
    cst_key
from bronze.cust_info
where cst_key != trim(cst_key) or cst_key is null;

-- checking space in firstname and lastname

select 
    cst_firstName
from bronze.cust_info 
where cst_firstName != trim(cst_firstName)

select
    cst_lastName
from bronze.cust_info 
where cst_lastName != trim(cst_lastName)

--checking maritial status
select distinct(cst_marital_status) from bronze.cust_info;

--checking gender status
select distinct(csr_gndr) from bronze.cust_info;

--bronze.prd_info
-- checking prd_id is null or not.
SELECT 
    prd_id 
FROM bronze.prd_info
where prd_id IS NULL;

--checking null in prd_key

select 
    prd_key
from bronze.prd_info
where prd_key is null or prd_key != trim(prd_key);

-- checking prd_name and null present or not
select 
    prd_name
from bronze.prd_info
where  prd_name is null or prd_name != trim(prd_name);

--zChecking nulls and negative in prd_cost

select 
    prd_cost,
    isnull(prd_cost,0) 
from bronze.prd_info
where prd_cost <0 or prd_cost is null

--checking prd_line 
select distinct(prd_line) from
bronze.prd_info

--checking start date and end date

SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'prd_info'
  AND COLUMN_NAME = 'prd_start_date';

select * from(
select
    prd_start_date,
    Dateadd(day, -1, lead(prd_start_date) over (partition by prd_key order by prd_start_date)) updated_end,
    prd_end_date
from bronze.prd_info)t 
where updated_end is not null;

SELECT 
    * 
FROM bronze.prd_info
WHERE prd_end_date < prd_start_date;

--Testing sales_info

select * from bronze.sales_info;

--checking sls_odr_no if null present or not
select sls_odr_no,
        count(sls_odr_no)
from bronze.sales_info
group by sls_odr_no
having count(*) > 1 or sls_odr_no is null

--checking for invalid date
select sls_order_date from bronze.sales_info
where len(sls_order_date) != 8 or sls_order_date <=0 
;

select sls_ship_date from bronze.sales_info
where len(sls_ship_date) != 8 or sls_ship_date <=0 
;

select sls_due_date from bronze.sales_info
where len(sls_due_date) != 8 or sls_due_date <=0
;

--checking sales quantiy price

SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM bronze.sales_info
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;