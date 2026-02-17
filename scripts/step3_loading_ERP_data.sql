create or alter PROCEDURE bronze.load_data_to_SQL_erp as
BEGIN 
 DECLARE @start_time DATETIME,
		 @end_time DATETIME,
		 @difference INT
BEGIN TRY
	SET @start_time = GETDATE();
	print('==========================================================');
	print('PROCEDURE START TO LOAD DATA FROM CSV FILE TO SQL SERVER');
	print('==========================================================');

	print('');
	print('------------------------------------------------------')
	print 'FIRST TRUNCATE ALL DATA THEN LOAD THE DATA AGAIN';
	print 'USING FULL LOAD';
	print('------------------------------------------------------');
	print('**** This is ERP DATA ****')

	if OBJECT_ID('bronze.cust_az12','U') IS NOT NULL
		truncate table bronze.cust_az12;
	bulk insert bronze.cust_az12
	from 'D:\Increment switch\SQL\DATA\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
	);


	if OBJECT_ID('bronze.loc_a101','U') IS NOT NULL
		truncate table bronze.loc_a101;
	bulk insert bronze.loc_a101
	from 'D:\Increment switch\SQL\DATA\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
	);

	if OBJECT_ID('bronze.px_cat_g1v2','U') IS NOT NULL
		truncate table bronze.px_cat_g1v2;
	bulk insert bronze.px_cat_g1v2
	from 'D:\Increment switch\SQL\DATA\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
	);
	set @end_time = GETDATE();
	set @difference = DATEDIFF(MILLISECOND, @start_time, @end_time)
	print 'TOTAL TIME REQUIRED: ' + CAST(@difference as NVARCHAR) + 'seconds.'
END TRY
BEGIN CATCH
	print('SOME error occured')
END CATCH
END;
GO
