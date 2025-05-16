-- Check the data is clean or not for data integration
-- Check and see whether the integration key has other values
SELECT 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	WHEN 'M' THEN 'MOUNTAIN'
	WHEN  'R' THEN 'ROAD'
	WHEN 'S' THEN 'OTHER SALES'
	WHEN 'T' THEN 'TOURING'
	ELSE 'n/a'
END AS prd_line,
prd_start_dt,
prd_end_dt
FROM bronze.crm_prd_info
WHERE REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') NOT IN
(SELECT DISTINCT id from bronze.erp_px_cat_g1v2)

-- Check and see whether the integration key has other values (Same but for different table)
SELECT 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	WHEN 'M' THEN 'MOUNTAIN'
	WHEN  'R' THEN 'ROAD'
	WHEN 'S' THEN 'OTHER SALES'
	WHEN 'T' THEN 'TOURING'
	ELSE 'n/a'
END AS prd_line,
prd_start_dt,
prd_end_dt
FROM bronze.crm_prd_info
WHERE SUBSTRING(prd_key, 7, LEN(prd_key)) NOT IN
(SELECT sls_prd_key from bronze.crm_sales_details)


-- Insertion
TRUNCATE TABLE silver.crm_prd_info
INSERT INTO silver.crm_prd_info(
	prd_id ,
	cat_id,
	prd_key ,
	prd_nm ,
	prd_cost ,
	prd_line,
	prd_start_dt ,
	prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	WHEN 'M' THEN 'MOUNTAIN'
	WHEN  'R' THEN 'ROAD'
	WHEN 'S' THEN 'OTHER SALES'
	WHEN 'T' THEN 'TOURING'
	ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(DATEADD(DAY, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info

SELECT * from silver.crm_sales_details



