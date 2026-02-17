create or alter procedure silver.load_data_silver_layer as 
begin
declare
    @start_time datetime, @end_time datetime, @difference INT

begin try 
    set @start_time = getdate();
    --truncating table to prepare for full load
    truncate table silver.cust_info;
    --Adding data to silver.cust_info
    Insert into silver.cust_info(
        cst_id, 
        cst_key,
        cst_firstName,
        cst_lastName,
        cst_marital_status,
        csr_gndr,
        cst_create_date
    )
    select
        cst_id,
        cst_key,
        trim(cst_firstName) as cst_firstName,
        trim(cst_lastName) as cst_firstName,
        case 
        when trim(upper(cst_marital_status)) = 'M' then  'Married'
        when trim(upper(cst_marital_status)) = 'S' then 'Single'
        else 'n/a' 
        end as cst_marital_status,
        case 
        when trim(upper(csr_gndr)) = 'M' then  'Male'
        when trim(upper(csr_gndr)) = 'F' then 'Female'
        else 'n/a' 
        end as csr_gndr,
        cst_create_date
    from (    
    SELECT 
        *,
        ROW_NUMBER() over(partition by cst_id order by cst_create_date) as flag_test
    FROM bronze.cust_info where cst_id is not null) t where flag_test = 1;


    --=================================================================================--

    --truncating table to prepare for full load
    truncate table silver.prd_info;
    --Adding data to silver.prd_info
    Insert into silver.prd_info(
    prd_id,
    prd_key,
    id,
    cid,
    prd_name,
    prd_cost,
    prd_line,
    prd_start_date,
    prd_end_date
    )

    select
        prd_id,
        prd_key,
        replace(substring(prd_key,1,5),'-','_') as id,
        substring(prd_key,7,len(prd_key)) as cid,
        prd_name,
        isnull(prd_cost,0) as prd_cost,
        CASE 
				    WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				    WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				    WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				    WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				    ELSE 'n/a'
			    END AS prd_line,
                prd_start_date,
                Dateadd(day, -1, lead(prd_start_date) over (partition by prd_key order by prd_start_date)) prd_end_date
        from bronze.prd_info


        --==========================================================================--

     --truncating table to prepare for full load
    truncate table silver.sales_info;
    --Adding data to silver.sales_info
        insert into silver.sales_info(
        sls_odr_no,
    sls_prt_key,
    sls_cust_id,
    sls_order_date,
    sls_ship_date,
    sls_due_date,
    sls_sales,
    sls_quantity,
    sls_price
        )
        select
        sls_odr_no,
        sls_prt_key,
        sls_cust_id,
        case 
        when sls_order_date <=0 or len(sls_order_date) != 8 then NULL
        else cast(sls_order_date as date)
        end as sls_order_date,

        case 
        when sls_ship_date <=0 or len(sls_ship_date) != 8 then NULL
        else cast(sls_ship_date as date)
        end as sls_ship_date,

        case 
        when sls_due_date <=0 or len(sls_due_date) != 8 then NULL
        else cast(sls_due_date as date)
        end as sls_due_date,

        case 
        when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity* abs(sls_price)
        then sls_quantity* abs(sls_price)
        else sls_sales
        end as sls_sales,
        sls_quantity,

        case 
        when sls_price is null or sls_price < 0 
        then sls_sales/nullif(sls_quantity,0)
        else sls_price
        end as sls_price
        from bronze.sales_info;

        set @end_time = getdate();
        set @difference = DATEDIFF(MILLISECOND, @start_time,@end_time);
        print'Time required to complete: ' + cast(@difference as nvarchar) + ' seconds' 
    end try
    begin catch
        print('error occurred')
    end catch
end;
go 

