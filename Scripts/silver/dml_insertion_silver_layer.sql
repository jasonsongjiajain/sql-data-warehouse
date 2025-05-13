-- Insertion of Clean data into silver layer table ( Customer Info ) 
Insert into 
silver.crm_cust_info(
	cst_id, 
	cst_key, 
	cst_firstname, 
	cst_lastname,
	cst_material_status,
	cst_gender,
	cst_create_date)
SELECT 
cst_id, 
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'SINGLE'
	WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'MARRIED'
	ELSE 'n/a'
END cst_gender,
CASE WHEN UPPER(TRIM(cst_gender)) = 'F' THEN 'FEMALE'
	WHEN UPPER(TRIM(cst_gender)) = 'M' THEN 'MALE'
	ELSE 'n/a'
END cst_gender,
cst_create_date
FROM(
select 
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
from bronze.crm_cust_info WHERE cst_id IS NOT NULL)t WHERE flag_last = 1
