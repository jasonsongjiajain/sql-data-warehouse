IF OBJECT_ID('silver.crm_cust_info','U') is not null
	drop table silver.crm_cust_info;
create table silver.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gender NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
 );

 IF OBJECT_ID('silver.crm_prd_info','U') is not null
	drop table silver.crm_prd_info;
 create table silver.crm_prd_info(
	prd_id INT,
	cat_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost NVARCHAR(50),
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
 );


IF OBJECT_ID('silver.crm_sales_details','U') is not null
	drop table silver.crm_sales_details;
 create table silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME DEFAULT GETDATE()
 );


IF OBJECT_ID('silver.erp_loc_a101','U') is not null
	drop table silver.erp_loc_a101;
 create table silver.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
 );

IF OBJECT_ID('silver.erp_cust_az12','U') is not null
	drop table silver.erp_cust_az12;
 create table silver.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen nVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
 );

IF OBJECT_ID('silver.erp_px_cat_g1v2','U') is not null
	drop table silver.erp_px_cat_g1v2;
 create table silver.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
 );