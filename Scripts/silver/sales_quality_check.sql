-- Data Quality Check

-- Check whether this data table can be integrated or not
-- Very important as integration is needed during gold layer
-- Product Details -> Sales Details
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_prd_key not in (SELECT prd_key FROM silver.crm_prd_info)

-- Customer Details -> Sales Details
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_cust_id not in (SELECT cst_id FROM silver.crm_cust_info)

-- Check for Invalid Dates
SELECT NULLIF(sls_order_dt, 0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt) != 8  
OR sls_order_dt> 20500101
OR sls_order_dt> 19000101


-- If there is a start date and end date, need to clean it to make sure the the end date is not earlier that the start date
-- Check for Invalid Dates
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_due_dt OR sls_order_dt > sls_ship_dt

-- Check Data Consistency Between Sales, Quantity and Price
-- Sales = Quantity * Price
-- Values must not be NULL, Zero, or negative
SELECT  sls_sales, sls_quantity, sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price is NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY  sls_sales, sls_quantity, sls_price

-- Therefore we need to clean and transform the data for price, sales and quantity
-- But before all of these, there is need to  consult the source system or sales team before cleaning sales-related data
-- Why? because there might be meanings through the data that is cleaned like Business Rules & Exceptions(Promotions & Free Gifts etc)
--Example: A price of 0 might mean a promotional item or free sample, not a missing value.
-- A negative quantity could mean a returned item, not a data entry mistake.
