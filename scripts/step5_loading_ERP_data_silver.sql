create or alter procedure silver.load_data_to_silver_ERP as
begin
declare
	@starttime Datetime, @endtime datetime, @difference INT
begin try
	set @starttime = GETDATE();
	truncate table silver.cust_az12;
	insert into silver.cust_az12(
	cid,
	bdate,
	gen
	)
	select 
		case
		when cid like 'NAS%' then substring(cid , 4, len(cid))
		else cid
		end as cid,
		case 
		when bdate > getdate() 
		then null
		else bdate 
		end as bdate,
		case 
		when upper(trim(gen)) in ('F','FEMALE') then 'Female'
		when upper(trim(gen)) in ('M','MALE') then 'Male'
		else 'n/a'
		end as gen
	from bronze.cust_az12;

	truncate table silver.loc_a101;
	insert into silver.loc_a101(
	cid,
	cntry
	)
	select 
	replace(cid,'-',''),
	case 
	when upper(trim(cntry)) in ('US','UNITED STATES', 'USA', 'AMERICA', 'UNITED STATES OF AMERICA') then 'USA'
	WHEN upper(TRIM(cntry)) in ('DE', 'GERMANY') THEN 'Germany'
	when upper(trim(cntry)) in ('' , null) then 'n/a'
	else cntry
	end cntry
	from bronze.loc_a101;

	truncate table silver.px_cat_g1v2;
	Insert into silver.px_cat_g1v2(
	id,
	cat,
	subcat,
	maintenance
	)
	select
	id,
	trim(cat),
	TRIM(subcat),
	TRIM(maintenance)
	from bronze.px_cat_g1v2;
	set @endtime = GETDATE();
	set @difference = DATEDIFF(MILLISECOND, @starttime, @endtime)
	print 'Total time required to complete '+ cast(@difference as nvarchar) +' seconds'
end try
begin catch
	print'some error occured'
end catch
end;
go

