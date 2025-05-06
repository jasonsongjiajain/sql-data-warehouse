USE DataWarehouse;
GO

CREATE or ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT('===================================')
		PRINT('LOADING BRONZE LAYER')
		PRINT('===================================')

		PRINT('===================================')
		PRINT('LOADING CRM TABLES')
		PRINT('===================================')

		SET @start_time = GETDATE();
		PRINT ('>> Truncating Table: bronze.crm_cust_info')
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT ('>> Inserting Data into Table: bronze.crm_cust_info')
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\sjiaj\Documents\Data_Engineer\DataWarehouse\sql-data-warehouse\Datasets\source_crm\cust_info.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('>> LOAD DURATION' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)) + ' seconds';

		SET @start_time = GETDATE();
		PRINT ('>> Truncating Table: bronze.crm_prd_info')
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT ('>> Inserting Data into Table: bronze.crm_prd_info')
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\sjiaj\Documents\Data_Engineer\DataWarehouse\sql-data-warehouse\Datasets\source_crm\prd_info.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('>> LOAD DURATION' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)) + ' seconds';

		SET @start_time = GETDATE();
		PRINT ('>> Truncating Table: bronze.crm_sales_details')
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT ('>> Inserting Data into Table: bronze.crm_sales_details')
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\sjiaj\Documents\Data_Engineer\DataWarehouse\sql-data-warehouse\Datasets\source_crm\sales_details.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('>> LOAD DURATION' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)) + ' seconds';

		PRINT('===================================')
		PRINT('LOADING ERP TABLES')
		PRINT('===================================')

		SET @start_time = GETDATE();
		PRINT ('>> Truncating Table: bronze.erp_cust_az12')
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT ('>> Inserting Data into Table: bronze.erp_cust_az12')
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\sjiaj\Documents\Data_Engineer\DataWarehouse\sql-data-warehouse\Datasets\source_erp\CUST_AZ12.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('>> LOAD DURATION' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)) + ' seconds';

		SET @start_time = GETDATE();
		PRINT ('>> Truncating Table: bronze.erp_loc_a101')
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT ('>> Inserting Data into Table: bronze.erp_loc_a101')
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\sjiaj\Documents\Data_Engineer\DataWarehouse\sql-data-warehouse\Datasets\source_erp\LOC_A101.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('>> LOAD DURATION' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)) + ' seconds';

		SET @start_time = GETDATE();
		PRINT ('>> Truncating Table: bronze.erp_px_cat_g1v2')
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT ('>> Inserting Data into Table: bronze.erp_px_cat_g1v2')
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\sjiaj\Documents\Data_Engineer\DataWarehouse\sql-data-warehouse\Datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT('>> LOAD DURATION' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)) + ' seconds';
	END TRY
	BEGIN CATCH
	END CATCH

END

EXEC bronze.load_bronze