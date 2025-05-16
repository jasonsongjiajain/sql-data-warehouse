-- Quality Check for CRM Customer Details ( Bronze Layer )
-- Few things that we need to take care of 
-- 1. Check for Duplicate Data
-- 2. Check whether the string data values are perfectly align
-- 3. check for NUll values( Change to n/a for data warehouse )
-- 4. Change low cardinaluty columns to string long columns( s -> single...etc)

-- Check for null or duplicate values in primary key
-- Check Repeated ID for Customer Details Table
select cst_id, COUNT(*) from silver.crm_cust_info group by cst_id having COUNT(*) > 1 or cst_id IS NULL

-- Found out repeated cst_id and null values ( Thes rows must no included in the silve layer table )
select * from (
select 
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
from bronze.crm_cust_info)t WHERE flag_last != 1

-- Check Unwanted Spaces for String Values
select cst_firstname from bronze.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

-- Check the data types available in the columns
SELECT DISTINCT(cst_gender) FROM bronze.crm_cust_info




-- Quality Check ( Silver Layer ) 

-- Check for null or duplicate values in primary key
-- Check Repeated ID for Customer Details Table
select cst_id, COUNT(*) from silver.crm_cust_info group by cst_id having COUNT(*) > 1 or cst_id IS NULL

-- Found out repeated cst_id and null values ( Thes rows must no included in the silve layer table )
select * from (
select 
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
from silver.crm_cust_info)t WHERE flag_last != 1

-- Check Unwanted Spaces for String Values
select cst_firstname from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

-- Check the data types available in the columns
SELECT DISTINCT(cst_gender) FROM silver.crm_cust_info