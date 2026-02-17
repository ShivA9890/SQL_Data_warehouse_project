create or alter PROCEDURE bronze.load_data_to_SQL_crm as
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
	print('**** This is CRM DATA ****')

	if OBJECT_ID('bronze.cust_info','U') IS NOT NULL
		truncate table bronze.cust_info;
	bulk insert bronze.cust_info
	from 'D:\Increment switch\SQL\DATA\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
	);


	if OBJECT_ID('bronze.prd_info','U') IS NOT NULL
		truncate table bronze.prd_info;
	bulk insert bronze.prd_info
	from 'D:\Increment switch\SQL\DATA\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with(
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
	);

	if OBJECT_ID('bronze.sales_info','U') IS NOT NULL
		truncate table bronze.sales_info;
	bulk insert bronze.sales_info
	from 'D:\Increment switch\SQL\DATA\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
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
